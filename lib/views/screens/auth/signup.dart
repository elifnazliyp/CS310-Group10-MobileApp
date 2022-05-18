import 'package:eyesu_project/views/screens/auth/login_screen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../../../const.dart';

class Signup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        alignment:Alignment.center,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                    backgroundColor: Colors.blue,
                  ),
                  Positioned(
                    bottom:-10,
                    left:80,
                    child: IconButton(
                    onPressed: () {
                    
                  },
                  icon:Icon(Icons.add_a_photo),
                  ))
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width:MediaQuery.of(context).size.width -40,
                height: 50,
                decoration: BoxDecoration(
                  color:buttonColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold)),
                )
              ),
              SizedBox(height: 20,),
              
              
              
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?',
                  style:TextStyle(fontSize:20),
                  ),
                SizedBox(
                  width:5,
                ),
                  InkWell(
                    onTap:() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: buttonColor),
                      ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}