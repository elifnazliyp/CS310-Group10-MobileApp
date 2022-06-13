
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/views/screens/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ChangePassScreen extends StatefulWidget {
  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {

  final TextEditingController _password = TextEditingController();
  final TextEditingController _newpassword1 = TextEditingController();
  final TextEditingController _newpassword2 = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
              backgroundColor: Colors.black12,
              
            ),
      body:Container(
        alignment:Alignment.center,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              TextField(
                controller: _password,
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'Enter Current Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _newpassword1,
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'Enter New Password',
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _newpassword2,
                decoration:InputDecoration(
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:'Enter New Password Again',
                  prefixIcon: Icon(Icons.password),
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
                child: InkWell(
                  onTap: ()  {
                    //print (_newpassword1.text);
                    //print (_newpassword2.text);

                    if (_newpassword1.text==_newpassword2.text){

                      authController.updatePassword(_newpassword1.text);
                      Navigator.pushNamed(context, "/Profilescreen");
                    }
                    else {
                      //showAlertBox();
                    }


                  },
                    


                    //await user?.reauthenticateWithCredential(credential);
                    
                    
                  
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