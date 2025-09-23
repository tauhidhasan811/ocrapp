import 'package:flutter/services.dart';

class SmartReplyService {
  static const _channel = MethodChannel('ocrapp/smart_reply');

  /// Pass a list of messages to ML Kit Smart Reply
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

  /// Convert extracted text into a conversation message for Smart Reply
  List<Map<String, dynamic>> toConversation(String extractedText) {
    return [
      {
        'text': extractedText,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'isLocalUser': false,  // It's a message from 'remote' side
        'userId': 'system'
      }
    ];
  }
}
