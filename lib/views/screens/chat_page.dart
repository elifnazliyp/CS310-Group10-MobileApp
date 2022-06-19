

import 'package:firebase_crud_app/views/screens/widgets/message_widget.dart';
import 'package:firebase_crud_app/views/screens/widgets/messages_widgets.dart';
import 'package:firebase_crud_app/views/screens/widgets/chat_header_widget.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:firebase_crud_app/views/screens/widgets/new_message_widget.dart';
import 'package:firebase_crud_app/views/screens/widgets/profile_header_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final User user;

  const ChatPage({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromARGB(255, 204, 19, 6),
        body: SafeArea(
          child: Column(
            children: [
              ProfileHeaderWidget(name: widget.user.name),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: MessagesWidget(uid: widget.user.uid),
                ),
              ),
              NewMessageWidget(uid: widget.user.uid)
            ],
          ),
        ),
      );
}