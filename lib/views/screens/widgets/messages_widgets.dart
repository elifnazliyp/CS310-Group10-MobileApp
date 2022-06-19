import 'package:firebase_crud_app/views/screens/widgets/data.dart';
import 'package:firebase_crud_app/views/screens/widgets/firebase_api.dart';
import 'package:firebase_crud_app/models/message.dart';
import 'package:firebase_crud_app/views/screens/widgets/message_widget.dart';

import 'package:flutter/material.dart';

import 'package:firebase_crud_app/models/message_utils.dart';

class MessagesWidget extends StatelessWidget {
  final String uid;

  const MessagesWidget({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Message>>(
        stream: FirebaseApi.getMessages(uid),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final messages = snapshot.data;

                return messages!.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                        final message = messages[index];

                          return MessageWidget(
                            message: message,
                            isMe: message.uid == myId,
                          );
                        },
                      );
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      );
}