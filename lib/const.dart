import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eyesu_project/controllers/auth_controllers.dart';
import 'package:eyesu_project/views/screens/auth/add_video_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//List of Pages
final pages = [
    Text('Home Page'),
    Text('Search Page'),
    AddVideoScreen(),
    Text('Message Page'),
    Text('Profile Page'),
  ];




//colors
const backgroundColor = Colors.black;
var buttonColor=Colors.red[400];



//firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage= FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//Controller
var authController = AuthController.instance;