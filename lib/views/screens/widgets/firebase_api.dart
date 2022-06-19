import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/views/screens/widgets/data.dart';
import 'package:firebase_crud_app/models/message.dart';
import 'package:firebase_crud_app/models/user.dart';

import 'package:firebase_crud_app/models/message_utils.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String uid, String message) async {
    final refMessages =
        FirebaseFirestore.instance.collection('chats/$uid/messages');

    final newMessage = Message(
      uid: myId,
      profilePhoto: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(uid)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

  static Stream<List<Message>> getMessages(String uid) =>
      FirebaseFirestore.instance
          .collection('chats/$uid/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(
           uid: userDoc.id,
           name: user.name,
           email: user.email,
           profilePhoto: user.profilePhoto,
           lastMessageTime:user.lastMessageTime);

        await userDoc.set(newUser.toJson());
      }
    }
  }
}