import 'package:bubble_chat/constants.dart';
import 'package:bubble_chat/widgets/chat/messages.dart';
import 'package:bubble_chat/widgets/chat/newmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.configure(onMessage: (message) {
      print(message);
      return;
    }, onLaunch: (message) {
      print(message);
      return;
    }, onResume: (message) {
      print(message);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kIconColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Bubble Chat'),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: 'LogOut',
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          'LogOut',
                        ),
                        Icon(Icons.exit_to_app),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'LogOut') {
                  FirebaseAuth.instance.signOut();
                }
              }),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
