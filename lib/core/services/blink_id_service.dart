import 'package:blinkid_flutter/microblink_scanner.dart';
import 'package:blinkid_flutter/recognizers/blink_id_combined_recognizer.dart';

import 'package:flutter/material.dart';
import 'package:ocr/core/models/scan_result.dart';
import 'package:ocr/core/services/image_file_database.dart';

class BlinkIdService with ChangeNotifier {
  String resultString = "";
  String fullDocumentFrontImageBase64 = "";
  String fullDocumentBackImageBase64 = "";
  String faceImageBase64 = "";
  bool isDetected = false;

  double comparisonResult;

  ImageFileDatabase _imageFileDatabase = ImageFileDatabase();

  ScanResult scanResult;

  Future<bool> scan(BuildContext context) async {
    String license = _getSpecificPlatformLicense(context);

    var idRecognizer = BlinkIdCombinedRecognizer();
    idRecognizer.returnFullDocumentImage = true;
    idRecognizer.returnFaceImage = true;

    BlinkIdOverlaySettings settings = BlinkIdOverlaySettings();

    var results = await MicroblinkScanner.scanWithCamera(
        RecognizerCollection([idRecognizer]), settings, license);

    if (results.isEmpty) return false;

    for (RecognizerResult result in results) {
      if (result is BlinkIdCombinedRecognizerResult) {
        if (result.mrzResult.documentType == MrtdDocumentType.Passport) {
          getPassportResult(result);
        } else {
          getIdResult(result);
        }

        fullDocumentFrontImageBase64 = result.fullDocumentFrontImage;
        fullDocumentBackImageBase64 = result.fullDocumentBackImage;
        faceImageBase64 = result.faceImage;

        if (result.fullDocumentFrontImage != null && result.fullDocumentFrontImage != "") {
          scanResult.faceImageBase64 = result.fullDocumentFrontImage;
          scanResult.aboutMeImage = result.faceImage;

          if (result.fullDocumentFrontImage != null && result.fullDocumentFrontImage != "")
            await _imageFileDatabase.saveImageFile(result.fullDocumentFrontImage);

          await _imageFileDatabase.readImageFile();

          await _imageFileDatabase.readFile().then((imageFile) {
            scanResult.imageFromFile = imageFile;
            notifyListeners();
          });
        }
      }
    }

    return true;
  }

  _getSpecificPlatformLicense(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return "sRwAAAEaY29tLnlvdW5lcy5mYWNlcmVjb2duaXRpb27j0CkE8HK25Y46ih8gV3Ok61BqbqzlN2RqyMS6BVS9wxYbhof9G7gB7Jb0H210LejjjJHmC9j0KcZSe20TOOND2A3/zBUoIQvw0r0FoKBjqSNCT/UsdKpCydhFf1SYvLhOnja3/a3T5+F9gJ6dAqC0lKv3r6YL09kwgz1hSWYixBqpg3X/oamtmXbcotyphgWTIm8h7qsbEnh/MN1XJ/LUV51/8vVvVjwFtMY1M3hM73+wX4QXoJuDMB7WjX8Hz++WK5d9EKYKFA3OU4QaZfLbyGdtOwT31R+mvYgGSIYukDJLINvBolOqBuDB+Ne9+ZxtyfAg5A5orKMM7cquvUqJ+Mk=";
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return "sRwAAAASY29tLnNvZnRwb3NreWMub2NyaHKAcYH3Wfd6C2q3DZYqBugmQ+4dJ9sAoX2teuoQC87HSQGHyuyAtSQgBbsibso6O4YJZ47pRjjpVuayubb0LHp4sQOGQkr10HPH7DOtsqIo8Ks0SK3+ydq2qEUzwkt4wEwHCyLEbVAXdO9hUkMt/Czu2Mco+Fjjplp8jUWI+aLTVdgfzyHnrNlERd4PZJZJaWMujHz+6e17vuSQxZ3qxN4hekG8VtZDzgLsg+Q+eMzRbXW+PV2UyG+irUkMpJ1tJ8ASYoazRQYUo3+tnKBR7K9oLvsZaw+syPkm0XwgRBuTH7QktEJiczJvDHcbAiXsuE0zltEQNyaw14YR0Xh1Tx8e";
    }
  }

  String _getDateFormat(Date date) {
    return date != null ? "${date.day}/${date.month}/${date.year}" : "N/A";
  }

  void getIdResult(BlinkIdCombinedRecognizerResult result) {
    scanResult = ScanResult(
      firstName: result.firstName ?? "N/A",
      lastName: result.lastName ?? "N/A",
      fullName: result.fullName ?? "N/A",
      documentNumber: result.documentNumber ?? "N/A",
      personalIdNumber: result.personalIdNumber ?? "N/A",
      nationality: result.nationality ?? "N/A",
      dateOfBirth: _getDateFormat(result.dateOfBirth),
      dateOfExpiry: _getDateFormat(result.dateOfExpiry),
    );

    isDetected = true;
    notifyListeners();
  }

  void getPassportResult(BlinkIdCombinedRecognizerResult result) {
    scanResult = ScanResult(
      firstName: result.firstName ?? "N/A",
      lastName: result.lastName ?? "N/A",
      fullName: result.fullName ?? "N/A",
      documentNumber: result.documentNumber ?? "N/A",
      personalIdNumber: result.personalIdNumber ?? "N/A",
      nationality: result.nationality ?? "N/A",
      dateOfBirth: _getDateFormat(result.dateOfBirth) ?? "N/A",
      dateOfExpiry: _getDateFormat(result.dateOfExpiry) ?? "N/A",
    );

    isDetected = true;
    notifyListeners();
  }
}
