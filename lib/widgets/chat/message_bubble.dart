import 'package:bubble_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isME;
  final Key key;
  final String username;
  final Timestamp time;
  final String imageUrl;

  MessageBubble(
      {this.message,
      this.isME,
      this.key,
      this.username,
      this.time,
      this.imageUrl});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isME ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: size.height * 0.2,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
              decoration: BoxDecoration(
                color: isME ? Color(0xffc5e3f6) : kSecWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight:
                      isME ? Radius.circular(0) : Radius.circular(20.0),
                  bottomLeft:
                      !isME ? Radius.circular(0) : Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    isME ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        color: Color(0xff364f6b), fontWeight: FontWeight.w600),
                  ),
                  Text(
                    message,
                    textAlign: isME ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                        color: isME ? Colors.black87 : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${time.toDate()}',
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isME ? null : 120.0,
          right: isME ? 134.0 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
