
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {

  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() {
    return _instance;
  }
  WebSocketService._internal();

  late WebSocketChannel? webSocketChannels;

  WebSocketChannel connect(String url, int id) {
    // final token = StorageManager.instance.getToken();
    String myUrl = "$url$id";
    webSocketChannels = IOWebSocketChannel.connect(myUrl);

    return webSocketChannels!;
  }
}