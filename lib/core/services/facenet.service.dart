import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:ocr/core/services/image_file_database.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tflite;
import 'package:image/image.dart' as imglib;

class FaceNetService {
  // singleton boilerplate
  static final FaceNetService _faceNetService = FaceNetService._internal();

  factory FaceNetService() {
    return _faceNetService;
  }

  // singleton boilerplate
  FaceNetService._internal();

  ImageFileDatabase _imageFileDatabase = ImageFileDatabase();

  tflite.Interpreter _interpreter;

  double threshold = 1.0;

  List _predictedData;
  List get predictedData => this._predictedData;

  List _predictedIdData;
  List get predictedIdData => this._predictedIdData;

  Future loadModel() async {
    try {
      final gpuDelegateV2 = tflite.GpuDelegateV2(
          options: tflite.GpuDelegateOptionsV2(
              false,
              tflite.TfLiteGpuInferenceUsage.fastSingleAnswer,
              tflite.TfLiteGpuInferencePriority.minLatency,
              tflite.TfLiteGpuInferencePriority.auto,
              tflite.TfLiteGpuInferencePriority.auto));

      var interpreterOptions = tflite.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      this._interpreter = await tflite.Interpreter.fromAsset(
          'mobilefacenet.tflite',
          options: interpreterOptions);
      print('model loaded successfully');
    } catch (e) {
      print('Failed to load model.');
      print(e);
    }
  }

  void setCurrentPrediction(CameraImage cameraImage, Face face) {
    /// crops the face from the image and transforms it to an array of data
    List input = _preProcess(cameraImage, face);

    /// then reshapes input and ouput to model format 🧑‍🔧
    input = input.reshape([1, 112, 112, 3]);
    List output = List(1 * 192).reshape([1, 192]);

    /// runs and transforms the data 🤖
    this._interpreter.run(input, output);
    output = output.reshape([192]);

    this._predictedData = List.from(output);
  }

  Future<void> setCurrentPredictionFromFile(File file, Face face) async {
    List input = await _preProcessIdFile(file, face);

    /// then reshapes input and ouput to model format 🧑‍🔧
    input = input.reshape([1, 112, 112, 3]);
    List output = List(1 * 192).reshape([1, 192]);

    /// runs and transforms the data 🤖
    this._interpreter.run(input, output);
    output = output.reshape([192]);

    this._predictedIdData = List.from(output);
  }

  /// _preProess: crops the image to be more easy
  /// to detect and transforms it to model input.
  /// [file]: current file image
  /// [face]: face detected
  Future<List> _preProcessIdFile(File file, Face face) async {
    /// Read image as array of int
    final bytes = await file.readAsBytes();

    double x = face.boundingBox.left - 10.0;
    double y = face.boundingBox.top - 10.0;
    double w = face.boundingBox.width + 10.0;
    double h = face.boundingBox.height + 10.0;
    imglib.Image croppedImage = imglib.copyCrop(
        imglib.decodeImage(bytes), x.round(), y.round(), w.round(), h.round());

    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    // transforms the cropped face to array data
    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  /// takes the predicted data previously saved and do inference
  Future<double> predict() async {
    /// search closer user prediction if exists
    return await _searchResult(this._predictedData);
  }

  /// _preProess: crops the image to be more easy
  /// to detect and transforms it to model input.
  /// [cameraImage]: current image
  /// [face]: face detected
  List _preProcess(CameraImage image, Face faceDetected) {
    // crops the face 💇
    imglib.Image croppedImage = _cropFace(image, faceDetected);
    imglib.Image img = imglib.copyResizeCropSquare(croppedImage, 112);

    // transforms the cropped face to array data
    Float32List imageAsList = imageToByteListFloat32(img);
    return imageAsList;
  }

  /// crops the face from the image 💇
  /// [cameraImage]: current image
  /// [face]: face detected
  _cropFace(CameraImage image, Face faceDetected) {
    imglib.Image convertedImage = _convertCameraImage(image);
    double x = faceDetected.boundingBox.left - 10.0;
    double y = faceDetected.boundingBox.top - 10.0;
    double w = faceDetected.boundingBox.width + 10.0;
    double h = faceDetected.boundingBox.height + 10.0;
    return imglib.copyCrop(
        convertedImage, x.round(), y.round(), w.round(), h.round());
  }

  /// converts ___CameraImage___ type to ___Image___ type
  /// [image]: image to be converted
  imglib.Image _convertCameraImage(CameraImage image) {
    int width = image.width;
    int height = image.height;
    var img = imglib.Image(width, height);
    const int hexFF = 0xFF000000;

    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = imglib.copyRotate(img, -90);
    return img1;
  }

  Float32List imageToByteListFloat32(imglib.Image image) {
    /// input size = 112
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);

        /// mean: 128
        /// std: 128
        buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  Future<Face> _getFaceFromFile(File file) async {
    final image = FirebaseVisionImage.fromFile(file);
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(mode: FaceDetectorMode.accurate),
    );
    final faces = await faceDetector.processImage(image);

    return faces[0];
  }

  /// [predictedData]: Array that represents the face by the MobileFaceNet model
  Future<double> _searchResult(List predictedData) async {
    final fileData = await _imageFileDatabase.readFile();
    Face face = await _getFaceFromFile(fileData);

    await setCurrentPredictionFromFile(fileData, face);

    // /// if no faces saved
    // if (predictedIdData == null) return null;
    double currDist = 0.0;

    /// search the  result 👓
    currDist = _euclideanDistance(this._predictedIdData, this._predictedData);
    print('***********************');
    print('Current distance is $currDist');
    print('***********************');
    return currDist;
  }

  /// Adds the power of the difference between each point
  /// then computes the sqrt of the result 📐
  double _euclideanDistance(List e1, List e2) {
    double sum = 0.0;
    for (int i = 0; i < e1.length; i++) {
      sum += pow((e1[i] - e2[i]), 2);
    }
    return sqrt(sum);
  }

  void setPredictedData(value) {
    this._predictedData = value;
  }

  void setPredictedIdData(value) {
    this._predictedIdData = value;
  }
}
