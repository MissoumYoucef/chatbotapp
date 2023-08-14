import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/chat_message.dart';
import 'package:http/http.dart' as http;

class ChatLogic {
  static List<ChatMessage> userMessages = [];

  static Future<void> sendMessage(String text) async {
    if (text.isNotEmpty) {
      userMessages.add(ChatMessage(text: text, isUser: true));

      final Uri apiUrl = Uri.parse("https://docs.cohere.com/reference/generate");
      final Map<String, String> headers = {
        "Authorization": "Bearer ${your_token}",
        "Content-Type": "application/json",
        "accept": "application/json",
        "Cohere-Version": "2022-12-06",
      };
      final Map<String, dynamic> requestBody = {
        "prompt": text,
        "max_tokens": 500,
        "return_likelihoods": "NONE",
        "truncate": "END",
        "model": "command",
      };

      if (kDebugMode) {
        print("Sending HTTP request...");
      }

      final http.Response response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      if (kDebugMode) {
        print("HTTP response received.");
      } // Add this line

      if (response.statusCode == 200) {
        final Map<String, dynamic> resJson = jsonDecode(response.body);
        final String botResponse = resJson['generations'][0]['text'];

        if (kDebugMode) {
          print("Bot response: $botResponse");
        } // Add this line

        userMessages.add(ChatMessage(text: botResponse, isUser: false));
      } else {
        if (kDebugMode) {
          print("HTTP Request failed with status code: ${response.statusCode}");
        }
      }
    }
  }
}
