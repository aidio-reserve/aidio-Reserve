import 'package:aitrip/providers/hotel_option_provider.dart';
import 'package:aitrip/providers/loading_provider.dart';
import 'package:aitrip/providers/message_list_provider.dart';
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
        int displayHotel = responseData['display_hotel'];
        // final Map<String, dynamic> hotelOption = responseData['hotel_option'];//ここで、後々繋ぎ込みを行う。
        final Map<String, dynamic> hotelOption = <String, dynamic>{
          "hotel_location": "東京都目黒区",
          "checkInDate": "08/31",
          "checkOutDate": "09/01",
          "number_of_people": "2",
          "price": "20000",
          "size_of_room": "single",
        };
        debugPrint('hotelOptionの型: ${hotelOption.runtimeType}');
        debugPrint('サーバーからのレスポンス: $responseMessage'
            'displayHotel: $displayHotel');
        ref.read(hotelOptionProvider.notifier).updateHotelOption(hotelOption);
        ref
            .read(messageListProvider.notifier)
            .addMessage(responseMessage, false, hotelOption, displayHotel);
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
