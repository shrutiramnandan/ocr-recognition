import 'dart:io';

class ScanResult {
  ScanResult({
    this.faceImageBase64,
    this.aboutMeImage,
    this.imageFromFile,
    this.firstName,
    this.lastName,
    this.fullName,
    this.documentNumber,
    this.personalIdNumber,
    this.nationality,
    this.dateOfBirth,
    this.dateOfExpiry,
  });

  String faceImageBase64;
  String aboutMeImage;
  File imageFromFile;
  String firstName;
  String lastName;
  String fullName;
  String documentNumber;
  String personalIdNumber;
  String nationality;
  String dateOfBirth;
  String dateOfExpiry;

  ScanResult.fromJson(Map<String, dynamic> json)
      : faceImageBase64 = json['faceImageBase64'],
        aboutMeImage = json['aboutMeImage'];

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'dateOfExpiry': dateOfExpiry,
        'nationality': nationality,
        'documentNumber': documentNumber,
        'faceImageBase64': faceImageBase64,
        'aboutMeImage': aboutMeImage

      };
}
