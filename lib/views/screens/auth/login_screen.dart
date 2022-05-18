import 'package:eyesu_project/views/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../const.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:EdgeInsets.all(20),
        alignment:Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                    ),
                hintText:'Email',
                prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    ),
                  hintText:'Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap:() {},
                child: Container(
                  width:MediaQuery.of(context).size.width -40,
                  height:50,
                  decoration: BoxDecoration(
                    color:buttonColor,
                    borderRadius: BorderRadius.circular(5),   
                     ),
                        
                child:Center(
                    child:Text(
                      'Login',
                      style:TextStyle(fontSize:20,fontWeight: FontWeight.bold,)
                    ),
                  ),
                  ),
              ),
              SizedBox(
                height:20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don"t have an account?',
                  style:TextStyle(fontSize:20),
                  ),
                SizedBox(
                  width:5,
                ),
                  InkWell(
                    onTap:() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Signup()));
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        color: buttonColor),
                      ),
                  ),
                ],
              )
            ],
          ),
        )


      )

    );
  }
}