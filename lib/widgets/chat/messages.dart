import 'package:bubble_chat/constants.dart';
import 'package:bubble_chat/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return SpinKitThreeBounce(
              color: kIconColor,
              size: MediaQuery.of(context).size.height * 0.07,
            );
          }

          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitThreeBounce(
                    color: kIconColor,
                    size: MediaQuery.of(context).size.height * 0.07,
                  );
                }

                final chatDocs = chatSnapshot.data.documents;

                return ListView.builder(
                  reverse: true,
                  itemCount: chatSnapshot.data.documents.length,
                  itemBuilder: (context, index) => MessageBubble(
                    username: chatDocs[index]['username'],
                    isME: chatDocs[index]['userId'] == futureSnapshot.data.uid,
                    message: chatDocs[index]['text'],
                    imageUrl: chatDocs[index]['userImage'],
                    time: chatDocs[index]['createdAt'],
                    key: ValueKey(chatDocs[index].documentID),
                  ),
                );
              });
        });
  }
}
