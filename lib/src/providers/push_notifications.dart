import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificacionProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _mensajesStreamController.stream;

  dispose() {
    _mensajesStreamController?.close();
  }

  void EnviarToken(String token) async {
    Map respuesta = new Map<String, dynamic>();
    respuesta["token"] = token;
    final response =
        await http.post('http://3.17.182.71:49120/Users', body: respuesta);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      enviarMensaje('Se registro correctamente');
    } else {
      enviarMensaje("No se pudo enviar el token :(");
    }
  }

  void enviarMensaje(mensaje) {
    _mensajesStreamController.sink.add(mensaje);
  }

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('FFC TOKEN');
      print(token);

      EnviarToken(token);

      // ezE-l5doqgM:APA91bFzaotDPI0AYd_Lll6Yfhkn2rq-qUq1xNnVWffQfsYjYT9N7ynLaA42qSng6CIxRZtOr_3hC_Yd-KqshI7gxXStC6KEjqAWdS6hPkJGnHD3Qo-0hSnSJhU7tkFw6pVWYaVP0hFp
    });

    _firebaseMessaging.configure(
      onMessage: (message) {
        print('====== On Message =====');
        print(message);

        String argumento = 'no-data';
        if (Platform.isIOS) {
          argumento = message['data']['comida'] ?? 'no-data';
          enviarMensaje(argumento);
        }

        if (Platform.isAndroid) {
          argumento = message['data']['comida'] ?? 'no-data';
          enviarMensaje(argumento);
        }
      },
      onLaunch: (message) {
        print('====== On Launch =====');
        print(message);

        String argumento = 'no-data';
        if (Platform.isIOS) {
          argumento = message['data']['comida'] ?? 'no-data';
          enviarMensaje(argumento);
        }

        if (Platform.isAndroid) {
          argumento = message['data']['comida'] ?? 'no-data';
          enviarMensaje(argumento);
        }
      },
      onResume: (message) {
        print('====== On Resume =====');
        print(message);

        String argumento = 'no-data';
        if (Platform.isIOS) {
          argumento = message['data']['comida'] ?? 'no-data';
          enviarMensaje(argumento);
        }

        if (Platform.isAndroid) {
          argumento = message['data']['comida'] ?? 'no-data';
          enviarMensaje(argumento);
        }
      },
    );
  }
}
