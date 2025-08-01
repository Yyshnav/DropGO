import 'dart:convert';
import 'dart:math';
import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/models/chat_model.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart'; // For VoidCallback

// Define callback types
typedef MessageCallback = void Function(MessageModel msg);
typedef TypingCallback = void Function(SenderType who, bool isTyping);
typedef ErrorCallback = void Function(Object error);

class ChatSocketService {
  WebSocketChannel? _channel;
  String? _orderId;
  Stream? _stream;
  bool get isConnected => _channel != null;

  MessageCallback? onMessage;
  TypingCallback? onTyping;
  ErrorCallback? onError;
  VoidCallback? onDone;

  void connect({
    required String orderId,
    String? token,
  }) {
    _orderId = orderId;
    final uri = Uri.parse(
      'ws://192.168.1.57:5000/ws/chat/$orderId/'
      '${token != null ? '?token=$token' : ''}',
    );
    
    // Uri(
    //   scheme: 'ws',
    //   host: '192.168.1.50',
    //   port: 5000,
    //   path: '/ws/chat/$orderId/',
    //   queryParameters: token != null ? {'token': token} : null,
    // );
    print('Connecting to WebSocket: $uri');
    try {
      _channel = WebSocketChannel.connect(uri);
      _stream = _channel!.stream;
      _listen();
      print('WebSocket connected');
      _reconnectAttempts = 0; 
    } catch (e) {
      print('❌ WebSocket connection failed: $e');
      onError?.call(e);
      _reconnect();
    }
  }

  void _listen() {
    _stream?.listen(
      (event) {
        try {
          final json = jsonDecode(event);
          final type = json['type']?.toString() ?? 'message';
          print('Received WebSocket event: $json');
          Get.log("=======================$json");

          if (type == 'typing') {
            onTyping?.call(
              senderTypeFromString(json['sender_type'] ?? 'USER'),
              json['is_typing'] == true,
            );
          } else {
            // onMessage?.call(MessageModel.fromJson(json));
            if (senderTypeFromString(json['sender_type']) == SenderType.user) {
              onMessage?.call(MessageModel.fromJson(json));
            } 
          }
        } catch (e) {
          print('❌ Error processing WebSocket event: $e');
          onError?.call(e);
        }
      },
      onDone: () {
        print('WebSocket closed');
        onDone?.call();
        _channel = null;
        _reconnect();
      },
      onError: (error) {
        print('❌ WebSocket error: $error');
        onError?.call(error);
        _channel = null;
        _reconnect();
      },
    );
  }

  int _reconnectAttempts = 0;
  static const _maxReconnectAttempts = 10;
  static const _baseDelay = Duration(seconds: 3);

  void _reconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts || isConnected || _orderId == null) {
      print('Reconnect stopped: attempts=$_reconnectAttempts, isConnected=$isConnected, orderId=$_orderId');
      return;
    }
    _reconnectAttempts++;
    final delay = _baseDelay * pow(2, _reconnectAttempts - 1);
    print('Reconnecting in ${delay.inSeconds} seconds (attempt $_reconnectAttempts)');
    Future.delayed(delay, () async {
      if (!isConnected) {
        try {
          final token = await DeliveryAuthApis.getToken();
          connect(orderId: _orderId!, token: token);
        } catch (e) {
          print('❌ Reconnect failed: $e');
          _reconnect();
        }
      }
    });
  }

  void sendText({
    required String orderId,
    required String message,
    required SenderType senderType,
  }) {
    if (!isConnected) {
      print('❌ Cannot send text: WebSocket not connected');
      throw Exception('WebSocket not connected');
    }
    final payload = {
      'message_type': 'Text',
      'orderId': orderId,
      'text': message,
      'sender_type': senderTypeToString(senderType),
      'timestamp': DateTime.now().toIso8601String(),
    };
    print('Sending WebSocket text: $payload');
    _channel!.sink.add(jsonEncode(payload));
  }

  // void sendMedia({
  //   required String orderId,
  //   required String mediaUrl,
  //   required MediaType mediaType,
  //   required SenderType senderType,
  //   String? caption,
  // }) {
  //   if (!isConnected) {
  //     print('❌ Cannot send media: WebSocket not connected');
  //     throw Exception('WebSocket not connected');
  //   }
  //   final payload = {
  //     'orderId': orderId,
  //     'text': caption ?? '',
  //     'sender_type': senderTypeToString(senderType),
  //     'file_url': mediaUrl,
  //     'message_type': mediaTypeToString(mediaType),
  //     'timestamp': DateTime.now().toIso8601String(),
  //   };
  //   print('Sending WebSocket media: $payload');
  //   _channel!.sink.add(jsonEncode(payload));
  // }

  void sendTyping({
    required String orderId,
    required SenderType senderType,
    required bool isTyping,
  }) {
    if (!isConnected) {
      print('❌ Cannot send typing: WebSocket not connected');
      return;
    }
    final payload = {
      'type': 'typing',
      'orderId': orderId,
      'sender_type': senderTypeToString(senderType),
      'is_typing': isTyping,
    };
    print('Sending WebSocket typing: $payload');
    _channel!.sink.add(jsonEncode(payload));
  }

  void sendMediaBase64({
  required String orderId,
  required String mediaBase64,
  required MediaType mediaType,
  required SenderType senderType,
  String? caption,
}) {
  if (!isConnected) {
    print('❌ WebSocket not connected');
    return;
  }

  final payload = {
    'orderId': orderId,
    'text': caption ?? '',
    'sender_type': senderTypeToString(senderType),
    'file_url': mediaBase64,
    'message_type': mediaTypeToString(mediaType),
    'timestamp': DateTime.now().toIso8601String(),
  };

  _channel!.sink.add(jsonEncode(payload));
}




  void disconnect() {
    _reconnectAttempts = 0;
    _orderId = null;
    _channel?.sink.close();
    _channel = null;
    print('WebSocket disconnected');
  }
}

