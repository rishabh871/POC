
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_bloc.dart';
import 'package:jai_poc/features/login/presentation/ui/login_page.dart';
import 'package:jai_poc/features/pdp/presentation/product_detail_page.dart';
import 'package:jai_poc/features/plp/presentation/product_list.dart';

import '../../main.dart';


class FirebasePushNotification {
  final _firebasemessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings("@drawable/ring");
    var iosInitialization = const DarwinInitializationSettings();

    var intializationSettings = InitializationSettings(
        android: androidInitialization, iOS: iosInitialization);
    await _flutterLocalNotificationsPlugin.initialize(intializationSettings,
        onDidReceiveNotificationResponse: (payload) {
      print("payload $payload");
    });
  }

  void firebaseInit() {
    // request permission
    _firebasemessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      // print("Notification Data onMessage ${message.data["dl"]}");

      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification Data onMessageOpenedApp ${message.data["dl"]}");
      var data = message.data["dl"].toString();
      var pageUrl = data.replaceAll("http://com.example.jaipoc/", "");
      redirectPage(pageUrl);
      // showNotification(message);
    });
    _firebasemessaging.getToken().then((token) {
      print("token is $token");
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      1.toString(),
      'High Importance Notifications',
      importance: Importance.high,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your channnel description',
      importance: Importance.high,
      icon: "@drawable/ring",
      // ticker: 'ticker'
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  void redirectPage(String pageUrl) {
    try {
      switch (pageUrl) {
        case "login":
          Navigator.push(
            globalNavigatorKey.currentContext as BuildContext,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => ProductBloc(),
                  child: LoginPage(),
                )),
          );
          break;
        case "plp":
          Navigator.push(
            globalNavigatorKey.currentContext as BuildContext,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => ProductBloc(),
                  child: ProductList(),
                )),
          );
          break;
        case "pdp":
          Navigator.push(
            globalNavigatorKey.currentContext as BuildContext,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => ProductBloc(),
                  child: ProductDetailPage(product: Product(title:"Iphone",description: "Iphone",imageUrl: "Iphone",price: "234",images: []),),
                )),
          );
          break;
      }
    } catch (e) {
      print(e);
    }
  }

}
