
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Import your services
import 'services/ocr_service.dart';
import 'services/text_classifier.dart';
import 'services/weather_service.dart';
import 'services/result_comparison.dart';


final OCRService _ocrService = OCRService();
final TextClassifier _classifier = TextClassifier();
final WeatherService _weatherService = WeatherService();
final ResultComparison _resultComparison = ResultComparison();

void main() {
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OCR Chatbot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatBotPage(),
    );
  }
}

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final List<Map<String, dynamic>> _messages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _sendImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);

    setState(() {
      _messages.add({
        'sender': 'user',
        'text': null,
        'image': imageFile,
      });
    });

    // Step 1: OCR
    String extractedText = await _ocrService.extractTextFromImage(imageFile);
    print("🔍 Extracted text: $extractedText");

    // Step 2: Classify
    final result = _classifier.classify(extractedText);
    print("Classifier result: $result");

    final type = result["category"];
    print("Type: $type");
    final imageData = result["matches"] as Map<String, dynamic>? ?? {};
    print("Matchaes: $imageData");


    String displayText;

    if (extractedText.trim().isEmpty) {
      displayText = "No text found in image";
    } else {
      String replyText;
      String compareResult = "";

      if (type == "Weather") {
        final Map<String, Map<String, double>> weatherData =  await _weatherService.findCityByTemperature();

        print("🌦 Live weather data: $weatherData");

        replyText = weatherData.entries
            .map((e) => "${e.key}: ${e.value['temp']?.toStringAsFixed(1)}°C")
            .join(", ");

        final List<String> comparison = _resultComparison.temperatureComparison(imageData, weatherData);
        compareResult = comparison.join("\n");

        print("🌦 Live weather data: $weatherData");

        replyText = weatherData.entries
            .map((e) => "${e.key}: ${e.value}°C")
            .join(", ");

      } else {
        replyText = "No reply generated yet (type not recognized)";
      }

      displayText =
      "Extracted text:\n$extractedText\n\nDetected Type: $type\nReply: $replyText\n\nComparison Between Results:\n$compareResult";
      print(displayText);
    }

    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': displayText,
        'image': null,
      });
    });

    print(" Bot reply added to messages");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: message['image'] != null
                        ? Image.file(message['image'],
                        height: 150, width: 150, fit: BoxFit.cover)
                        : Text(message['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: const Text("Gallery"),
                  onPressed: () => _sendImage(ImageSource.gallery),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                  onPressed: () => _sendImage(ImageSource.camera),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





