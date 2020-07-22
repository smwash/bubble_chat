import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff086972);
const kButtonColor = Color(0xffFF4F5A);
const kSecWhiteColor = Color(0xfff0f0f0);
const kIconColor = Color(0xff364f6b);

const kTextFieldDecoration = InputDecoration(
  //contentPadding: EdgeInsets.symmetric(vertical: 10.0),
  hintText: '',
  hintStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: kIconColor,
      textBaseline: TextBaseline.ideographic,
      letterSpacing: 1.1),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kIconColor,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: kButtonColor,
    ),
  ),
);
