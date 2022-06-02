
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';


class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _username = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  bool _switchValue=true;

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
                    onPressed: () => authController.pickImage(),
                  icon:Icon(Icons.add_a_photo),
                  ))
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _username,
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'New Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _email,
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'New Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                obscureText: true,
                controller: _password,
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'New Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20,),

             Container(
               child: Row(
                 children: [
                   Text('public'),
                    CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      },
                    ),
                    Text('private'),
                 ],
               ),
             ),
              
          
              Container(
                width:MediaQuery.of(context).size.width -40,
                height: 50,
                decoration: BoxDecoration(
                  color:buttonColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: InkWell(
                  onTap: () =>  authController.updateUser(_username.text, _password.text, authController.profilePhoto),
                  child: Center(
                    child: Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold)),
                  ),
                )
              ),
              SizedBox(height: 20,),
              
              
          
            ],
          ),
        ),
      )
    );
  }
}