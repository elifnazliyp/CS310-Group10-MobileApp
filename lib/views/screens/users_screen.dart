import 'package:firebase_crud_app/constants/constants.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          await firebaseAuth.signOut();
        },
        child: Text('Message Box'),
      )),
    );
  }
}
