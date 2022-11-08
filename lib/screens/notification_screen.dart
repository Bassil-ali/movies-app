import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class notificationscreen extends StatefulWidget {
  @override
  _notificationscreenState createState() => _notificationscreenState();
}

class _notificationscreenState extends State<notificationscreen> {
  String title = "empty";
  String messageTitle = "Empty";
  String notificationAlert = "Alert";
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(notificationAlert),
            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
    );
  }
}
