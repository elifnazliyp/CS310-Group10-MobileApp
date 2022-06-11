import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/auth_controller.dart';
import 'package:firebase_crud_app/views/auth/login_screen.dart';
import 'package:firebase_crud_app/views/auth/sign_up.dart';
import 'package:firebase_crud_app/views/screens/change_password_screen.dart';
import 'package:firebase_crud_app/views/screens/home_screen.dart';
import 'package:firebase_crud_app/views/screens/profile_edit_screen.dart';
import 'package:firebase_crud_app/views/screens/profile_screen.dart';
import 'package:firebase_crud_app/views/screens/walkthrough_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:firebase_crud_app/views/screens/welcom_page.dart';

bool isRunBefore= false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => {Get.put(AuthController())});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      
      //home: Welcome(),
      routes: {
        "/LoginScreen":(context) => LoginScreen(),
        "/SignUpScreen": ((context) => SignUp()),
        "/Welcome": (context) => Welcome(),
        "/Walkthrough": (context) => WalkthroughPage(),
        "/HomePage":(context) => HomeScreen(),
        "/ProfileEdit" : (context) => ProfileEditScreen(),
        "/Profilescreen" : (context) => ProfileScreen(uid: '',),
        "/ChangePassScreen" : (context) => ChangePassScreen(),
      },
     
      initialRoute: isRunBefore ? "/Welcome" : "/Walkthrough",
    );
  }
}

