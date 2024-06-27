import 'package:aitrip/providers/message_list_provider.dart';
import 'package:aitrip/providers/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatRepository {
  final String apiEndpoint = 'http://localhost:5001/chatting';
  final http.Client httpClient;
  final Ref ref;

  ChatRepository({required this.ref}) : httpClient = http.Client();

  Future<void> sendMessage(String threadId, String message) async {
    final Uri url = Uri.parse('http://localhost:5001/chatting');

    try {
      final response = await httpClient.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'threadId': threadId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('messageの送信が成功しました');
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String responseMessage = responseData['response'];
        int displayHotel = responseData['display-hotel'];
        debugPrint('サーバーからのレスポンス: $responseMessage'
            'displayHotel: $displayHotel');
        ref
            .read(messageListProvider.notifier)
            .addMessage(responseMessage, false, displayHotel);
        ref.read(isLoadingProvider.notifier).state = false;
        debugPrint('isLoadingがfalseに戻りました');
      } else {
        debugPrint('messageの送信に失敗しました: ${response.body}');
      }
    } catch (e) {
      debugPrint('messageの送信中にエラーが発生しました: $e');
    }
  }
}
