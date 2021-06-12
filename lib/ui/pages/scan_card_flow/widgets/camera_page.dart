import 'package:camera/camera.dart';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:ocr/core/services/blink_id_service.dart';
import 'package:ocr/core/services/camera.service.dart';
import 'package:ocr/core/services/facenet.service.dart';
import 'package:ocr/core/services/ml_vision_service.dart';
import 'package:ocr/global/theme/colors.dart';
import 'package:ocr/global/widgets/buttons.dart';
import 'package:ocr/ui/configuration/configuration.dart';
import 'package:ocr/ui/widgets/FacePainter.dart';
import 'package:ocr/ui/widgets/gradient_button.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription cameraDescription;
  final CameraService cameraService;

  const CameraPage({
    Key key,
    @required this.cameraDescription,
    @required this.cameraService,
  }) : super(key: key);

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  // /// Service injection
  // CameraService widget.cameraService = CameraService();
  MLVisionService _mlVisionService = MLVisionService();
  FaceNetService _faceNetService = FaceNetService();

  Future _initializeControllerFuture;

  bool cameraInitializated = false;
  bool _detectingFaces = false;
  bool isPictureTaken = false;

  // switchs when the user press the camera
  bool _saving = false;

  String imagePath;
  Size imageSize;
  Face faceDetected;
  bool isFaceDetected = false;

  @override
  void initState() {
    super.initState();

    /// starts the camera & start framing faces
    _start();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    widget.cameraService.dispose();
    super.dispose();
  }

  /// starts the camera & start framing faces
  _start() async {
    _initializeControllerFuture =
        widget.cameraService.startService(widget.cameraDescription);
    await _initializeControllerFuture;

    setState(() {
      cameraInitializated = true;
    });

    _frameFaces();
  }

  /// draws rectangles when detects faces
  _frameFaces() {
    imageSize = widget.cameraService.getImageSize();

    widget.cameraService.cameraController.startImageStream((image) async {
      if (widget.cameraService.cameraController != null) {
        // if its currently busy, avoids overprocessing
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          List<Face> faces = await _mlVisionService.getFacesFromImage(image);

          if (faces != null) {
            if (faces.length > 0) {
              // preprocessing the image
              setState(() {
                faceDetected = faces[0];
              });

              if (_saving) {
                _saving = false;
                _faceNetService.setCurrentPrediction(image, faceDetected);
              }
            } else {
              setState(() {
                faceDetected = null;
              });
            }
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  /// handles the button pressed event
  Future<void> onShot() async {
    if (faceDetected == null) {
      print('No face detected!');
    } else {
      imagePath =
          join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      _saving = true;
      print('saving');

      await Future.delayed(Duration(milliseconds: 500));
      await widget.cameraService.cameraController.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      await widget.cameraService.takePicture(imagePath);

      setState(() {
        isPictureTaken = true;
        isFaceDetected = true;
        print('face detected');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: AppColors.transparent,
        ),
        body: Center(
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _buildCameraWidget(context, width, height);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFloatingActionButton(context));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    /*
    return GradientButton(
      text: 'Take picture',
      // Provide an onPressed callback.
      onPressed: () async {
        try {
          // Ensure that the camera is initialized.
          await _initializeControllerFuture;
          // onShot event (takes the image and predict output)
          await onShot();

          final distance = await _predictUser();
          Provider.of<BlinkIdService>(context, listen: false).comparisonResult = distance;

          Navigator.pop(context, distance);
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
    );

     */
    final size = MediaQuery.of(context).size; //YNE06052021
    return RoundedBorderTextButton(
      title: 'Take picture',
      // Provide an onPressed callback.
      onTap: () async {
        try {
          // Ensure that the camera is initialized.
          await _initializeControllerFuture;
          // onShot event (takes the image and predict output)
          await onShot();

          final distance = await _predictUser();
          Provider.of<BlinkIdService>(context, listen: false).comparisonResult =
              distance;

          Navigator.pop(context, distance);
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
      height: size.height * 0.06,
      width: size.width,
      bgColor: MyTheme.buttonColor1,
      textColor: MyTheme.white,
      borderRadius: 10,
    );
  }

  Future<double> _predictUser() async {
    return await _faceNetService.predict();
  }

  _buildCameraWidget(
    BuildContext context,
    double width,
    double height,
  ) {
    return Transform.scale(
      scale: 1.0,
      child: AspectRatio(
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              width: width,
              height: width /
                  widget.cameraService.cameraController.value.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CameraPreview(widget.cameraService.cameraController),
                  CustomPaint(
                    painter:
                        FacePainter(face: faceDetected, imageSize: imageSize),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
