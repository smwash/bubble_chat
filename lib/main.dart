import 'package:bubble_chat/constants.dart';
import 'package:bubble_chat/screens/auth_screen.dart';
import 'package:bubble_chat/screens/chart_screen.dart';
import 'package:bubble_chat/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bubble Chat',
      theme: ThemeData(
        fontFamily: 'NunitoSans',
        //primaryColor: kButtonColor,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: kButtonColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.0),
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          }),
    );
  }
}
