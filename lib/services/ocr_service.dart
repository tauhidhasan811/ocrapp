import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class OCRService {
  final _textRecognizer = GoogleMlKit.vision.textRecognizer();

  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final RecognizedText recognizedText =
      await _textRecognizer.processImage(inputImage);

      return recognizedText.text;
    } catch (e) {
      return "Error extracting text: $e";
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}
