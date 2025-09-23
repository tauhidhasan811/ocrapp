import 'package:flutter/services.dart';

class SmartReplyService {
  static const _channel = MethodChannel('ocrapp/smart_reply');

  Future<List<String>> getSmartReply(List<Map<String, dynamic>> conversation) async {
    try {
      final List<dynamic> result = await _channel.invokeMethod(
        'getSmartReply',
        {'messages': conversation},
      );
      return result.cast<String>();
    } on PlatformException catch (e) {
      print("Error in Smart Reply: ${e.message}");
      return [];
    }
  }

  List<Map<String, dynamic>> toConversation(String extractedText) {
    return [
      {
        'text': extractedText,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'isLocalUser': false,
        'userId': 'system'
      }
    ];
  }
}
