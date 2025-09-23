

/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

void main() {
  runApp(const OCRApp());
}

class OCRApp extends StatelessWidget {
  const OCRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ocr app',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const OCRHomePage(),
    );
  }
}

class OCRHomePage extends StatefulWidget {
  const OCRHomePage({super.key});

  @override
  State<OCRHomePage> createState() => _OCRHomePageState();
}

class _OCRHomePageState extends State<OCRHomePage> {
  File? _image;
  String _extractedText = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _extractedText = 'Processing...';
    });

    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    setState(() {
      _extractedText = recognizedText.text;
    });

    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ocrapp')),
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
            onPressed: () => _pickImage(ImageSource.camera),
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: () => _pickImage(ImageSource.gallery),
            child: const Icon(Icons.photo),
          ),
        ],
      ),
    );
  }
}
*/
/*

import 'package:flutter/material.dart';
import 'presentation/pages/ocr_home_page.dart';

void main() {
  runApp(const OCRApp());
}

class OCRApp extends StatelessWidget {
  const OCRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCR App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const OCRHomePage(),
    );
  }
}

 */
/* Only Text Input
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Chatbot',
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
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      _messages.add({'sender': 'bot', 'text': 'You said: $text 🤖'});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Chatbot')),
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
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(message['text'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 */

/* Text and Image
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatbot with Image',
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
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _sendTextMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text, 'image': null});
      _messages.add({
        'sender': 'bot',
        'text': 'You said: $text 🤖',
        'image': null
      });
    });

    _controller.clear();
  }

  Future<void> _sendImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      _messages.add({
        'sender': 'user',
        'text': null,
        'image': File(pickedFile.path),
      });
      _messages.add({
        'sender': 'bot',
        'text': 'Nice image! 📸',
        'image': null,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot with Image')),
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
              children: [
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () => _sendImage(ImageSource.gallery),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () => _sendImage(ImageSource.camera),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendTextMessage,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 */

/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
      title: 'OCR Application',
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

  /*Future<void> _sendImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    setState(() {
      _messages.add({
        'sender': 'user',
        'text': null,
        'image': File(pickedFile.path),
      });
      _messages.add({
        'sender': 'bot',
        'text': 'Got your image! 📸',
        'image': null,
      });
    });
  }

   */
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


    String extractedText = await _ocrService.extractTextFromImage(imageFile);
    final result = _classifier.classify(extractedText);
    final type = result["category"];
    //final value = result["matches"];
    final List<double> value = List<double>.from(result["matches"] ?? []);


    String displayText;
    if (extractedText.trim().isEmpty) {
      displayText = "No text found in image";
    } else {
      /*final wordsList = extractedText
          .toLowerCase()
          .replaceAll(RegExp(r'[^\w\s°%]'), '')
          .split(RegExp(r'\s+'));

       */

      String replyText;
      String compareResult="";
      if (type == "Weather") {
        //final weatherData = await _weatherService.findCityByTemperature();
        final Map<String, double> weatherData =
              await _weatherService.findCityByTemperature();

        replyText = weatherData.entries
            .map((e) => "${e.key}: ${e.value}°C")
            .join(", ");
        final List<String> comparison = _resultComparison.temperatureComparison(value, weatherData);
        compareResult = comparison.join("\n");
      } else {
        replyText = "No reply generated yet";
      }

      displayText =
      "Extracted text:\n$extractedText\n\nDetected Type: $type\nReply: $replyText \n\nComparison Between results: \n$compareResult";
    }

    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': displayText,
        'image': null,
      });
    });

    /*
    var reply;

    if (type == "Weather") {
      reply = await _weatherService.findCityByTemperature();

      //print("Weather data: $reply");
    } else {
      // condition will be written after API is ready
    }


     */
    /*
    if (type == "Temperature") {
      reply = await _weatherService.findCityByTemperature("30");
    } else {
      reply = "Extracted Text: $extractedText\nType: $type $type reply: ${ "No reply generated"}";
    }

    List<String> words = extractedText
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s°%]'), '') // remove punctuation
        .split(RegExp(r'\s+'));
    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': extractedText.isEmpty
            ? "No text found in image "
            : "Extracted text:\n$extractedText\n\nDetected Type: $reply reply: ${words ?? "No reply generated"}",
        'image': null,
      });
    });

     */
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

 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Import your services
import 'services/ocr_service.dart';
import 'services/text_classifier.dart';
import 'services/weather_service.dart';
import 'services/result_comparison.dart';

// Initialize services
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
    //final List<double> value = List<double>.from(result["matches"] ?? []);
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
        // Step 3: Get weather data

        final Map<String, Map<String, double>> weatherData =  await _weatherService.findCityByTemperature();

        print("🌦 Live weather data: $weatherData");

// Build reply using only temperature
        replyText = weatherData.entries
            .map((e) => "${e.key}: ${e.value['temp']?.toStringAsFixed(1)}°C")
            .join(", ");

// Comparison
        //final List<String> comparison = _resultComparison.temperatureComparison(value, weatherData);
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

    // Step 5: Show reply
    setState(() {
      _messages.add({
        'sender': 'bot',
        'text': displayText,
        'image': null,
      });
    });

    print("✅ Bot reply added to messages");
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





