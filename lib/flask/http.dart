import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> startChat() async {
  var url = Uri.parse('http://10.0.2.2:5000/start'); // Androidエミュレータの場合
  // var url = Uri.parse('http://localhost:5000/start'); // iOSエミュレータやWebの場合、または適切なIPアドレスを使用

  try {
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'thread_id': '12345'}), // 適切なthread_idを送信
    );

    if (response.statusCode == 200) {
      debugPrint('ホテルリストの取得に成功しました: ${response.body}');
    } else {
      debugPrint('サーバーエラー: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('サーバーとの接続エラー: $e');
  }
}
