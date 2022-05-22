import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_crud_app/controlllers/auth_controller.dart';
import 'package:firebase_crud_app/views/screens/add_video_screen.dart';
import 'package:firebase_crud_app/views/screens/profile_screen.dart';
import 'package:firebase_crud_app/views/screens/search_screen.dart';
import 'package:firebase_crud_app/views/screens/users_screen.dart';
import 'package:firebase_crud_app/views/screens/video_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

List pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  UserScreen(),
  ProfileScreen(uid: authController.user.uid)
];

var firebaseAuth = FirebaseAuth.instance;

var firebaseStorage = FirebaseStorage.instance;

var firebaseStore = FirebaseFirestore.instance;

var authController = AuthController.instance;
