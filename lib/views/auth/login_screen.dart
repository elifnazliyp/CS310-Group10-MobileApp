import 'dart:ui';

import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/constants/dimensions.dart';
import 'package:firebase_crud_app/constants/styles.dart';
import 'package:firebase_crud_app/views/auth/sign_up.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoadin = false;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation:0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.red
          ),
          onPressed:() {
            Navigator.pushNamed(context, "/Welcome");
          } ),
      ),

      body: Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Dheight,
            ),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: Dheight,
            ),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                hintText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, "/HomePage");
                });
                authController.loginUser(_email.text, _password.text);
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: DfontSize,
                      fontWeight: Sbold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dheight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Need an Account? ',
                  style: TextStyle(
                    fontWeight: Sbold,
                    fontSize: DfontSize,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: Sbold,
                      color: buttonColor,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
