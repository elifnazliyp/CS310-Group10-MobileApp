import 'package:firebase_crud_app/models/message_utils.dart';
import 'package:flutter/material.dart';

import 'package:firebase_crud_app/models/message.dart';
class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String uid;
  final String profilePhoto;
  final String username;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.uid,
    required this.profilePhoto,
    required this.username,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        uid: json['uid'],
        profilePhoto: json['profilePhoto'],
        username: json['username'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'profilePhoto': profilePhoto,
        'username': username,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}