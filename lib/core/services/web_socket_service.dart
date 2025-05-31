import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  WebSocketService._internal();

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  bool _isConnected = false;
  String? _currentUrl;

  Future<void> connect(String url, int id, {void Function(dynamic)? onMessage}) async {
    final fullUrl = "$url$id";

    // If already connected to the same URL, do nothing
    if (_isConnected && _currentUrl == fullUrl) return;

    // Clean up any existing connection
    await disconnect();

    try {
      _channel = IOWebSocketChannel.connect(fullUrl);
      _currentUrl = fullUrl;

      _subscription = _channel!.stream.listen(
        (message) {
          debugPrint('Received: $message');
          onMessage?.call(message);
        },
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _isConnected = false;
        },
        onDone: () {
          debugPrint('WebSocket connection closed');
          _isConnected = false;
        },
      );

      _isConnected = true;
    } catch (e) {
      debugPrint('Connection error: $e');
      _isConnected = false;
      rethrow;
    }
  }

  Future<void> disconnect() async {
    try {
      await _subscription?.cancel();
      await _channel?.sink.close(status.goingAway);
    } catch (e) {
      debugPrint('Disconnection error: $e');
    } finally {
      _subscription = null;
      _channel = null;
      _isConnected = false;
      _currentUrl = null;
    }
  }

  bool get isConnected => _isConnected;
}
