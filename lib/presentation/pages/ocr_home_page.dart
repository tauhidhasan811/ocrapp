import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/image_repository.dart';
import '../../domain/services/ocr_service.dart';
import '../../domain/entities/ocr_result.dart';

class OCRHomePage extends StatefulWidget {
  const OCRHomePage({super.key});

  @override
  State<OCRHomePage> createState() => _OCRHomePageState();
}

class _OCRHomePageState extends State<OCRHomePage> {
  final ImageRepository _imageRepo = ImageRepository();
  final OcrService _ocrService = OcrService();

  File? _image;
  String _extractedText = '';

  Future<void> _handleImagePick(bool fromCamera) async {
    final pickedImage = fromCamera
        ? await _imageRepo.pickImageFromCamera()
        : await _imageRepo.pickImageFromGallery();

    if (pickedImage == null) return;

    setState(() {
      _image = pickedImage;
      _extractedText = 'Processing...';
    });

    final OcrResult result = await _ocrService.extractText(pickedImage);

    setState(() {
      _extractedText = result.text;
    });
  }

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_image != null)
              Image.file(_image!, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _extractedText.isEmpty
                      ? 'No text extracted yet.'
                      : _extractedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "camera",
            onPressed: () => _handleImagePick(true),
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: () => _handleImagePick(false),
            child: const Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
