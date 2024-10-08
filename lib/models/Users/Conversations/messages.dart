import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Message {
  final String text;
  final bool isSender;
  final Map<String, dynamic> hotelOption;
  final bool displayHotel;

  Message(
      {required this.text,
      required this.isSender,
      required this.hotelOption,
      required this.displayHotel});
}

class MessageListNotifier extends StateNotifier<List<Message>> {
  final Ref ref;

  MessageListNotifier(this.ref)
      : super([
          Message(
              text:
                  " こんにちは！どのような旅行をご希望ですか？\n \n  例. \t 北海道で海鮮丼を食べたい！ \n  例. \t 森林浴がしたい",
              isSender: false,
              hotelOption: <String, dynamic>{},
              displayHotel: false)
        ]);

  void addMessage(String text, bool isSender, Map<String, dynamic> hotelOption,
      bool displayHotel) {
    state = [
      ...state,
      Message(
          text: text,
          isSender: isSender,
          hotelOption: hotelOption,
          displayHotel: displayHotel)
    ];
    debugPrint(
        'Updated Message List:【 ${state.map((message) => 'text: ${message.text}, isSender: ${message.isSender}, hotelOption: ${message.hotelOption}, displayHotel: ${message.displayHotel}').toList()} 】');
  }

  void resetMessages() {
    state = [
      Message(
          text:
              " こんにちは！どのような旅行をご希望ですか？\n \n  例. \t 北海道で海鮮丼を食べたい！ \n  例. \t 森林浴がしたい",
          isSender: false,
          hotelOption: <String, dynamic>{},
          displayHotel: false)
    ];
    debugPrint('Reset Message List');
  }
}

final messageListProvider =
    StateNotifierProvider<MessageListNotifier, List<Message>>((ref) {
  return MessageListNotifier(ref);
});
