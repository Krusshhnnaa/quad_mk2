import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void init(String serverUrl) {
    socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter/web compatibility
          .disableAutoConnect() // we’ll connect manually
          .build(),
    );

    socket.onConnect((_) => print('Connected to Socket.IO'));
    socket.onDisconnect((_) => print('Disconnected'));

    // Listen for messages from server
    socket.on('receive_message', (data) {
      print('New message: $data');
      // TODO: notify your chat UI (via Provider, Bloc, etc.)
    });

    socket.connect();
  }

  void sendMessage(String message) {
    socket.emit('send_message', message);
  }

  void dispose() {
    socket.dispose();
  }
}
