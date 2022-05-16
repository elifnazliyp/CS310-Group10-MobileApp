import 'package:eyesu/responsive/mobile_screen_layout.dart';
import 'package:eyesu/responsive/responsive_layout_screen.dart';
import 'package:eyesu/responsive/web_screen_layout.dart';
import 'package:eyesu/screens/login_screen.dart';
import 'package:eyesu/screens/signup_screen.dart';
import 'package:eyesu/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDj_dr3x8kyVjVgSDhr95PDMVBReQALOgY', 
        appId: '1:488054433786:web:ec080af9b5a1923a762643', 
        messagingSenderId: '488054433786', 
        projectId: 'eyesu-5126b',
        storageBucket: 'eyesu-5126b.appspot.com',
      ),
    );
  }else{
    await Firebase.initializeApp();
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      //home: const ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())

      home: SignupScreen(),
    );
  }
}

