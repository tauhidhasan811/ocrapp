import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import '../entities/ocr_result.dart';

class OcrService {
  final textRecognizer = GoogleMlKit.vision.textRecognizer();

  Future<OcrResult> extractText(File image) async {
    final inputImage = InputImage.fromFile(image);
    final recognizedText = await textRecognizer.processImage(inputImage);

    return OcrResult(text: recognizedText.text);
  }

  void dispose() {
    textRecognizer.close();
  }
}
