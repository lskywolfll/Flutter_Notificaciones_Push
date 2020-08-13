import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificacionProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _mensajesStreamController.stream;

  dispose() {
    _mensajesStreamController?.close();
  }

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('FFC TOKEN');
      print(token);

      // ezE-l5doqgM:APA91bFzaotDPI0AYd_Lll6Yfhkn2rq-qUq1xNnVWffQfsYjYT9N7ynLaA42qSng6CIxRZtOr_3hC_Yd-KqshI7gxXStC6KEjqAWdS6hPkJGnHD3Qo-0hSnSJhU7tkFw6pVWYaVP0hFp
    });

    _firebaseMessaging.configure(
      onMessage: (message) {
        print('====== On Message =====');
        print(message);

        String argumento = 'no-data';
        if (Platform.isIOS) {
          argumento = message['data']['comida'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (message) {
        print('====== On Launch =====');
        print(message);
      },
      onResume: (message) {
        print('====== On Resume =====');
        print(message);

        // final noti = message['data']['comida'];
        // print(noti);
      },
    );
  }
}
