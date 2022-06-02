import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/constants/dimensions.dart';
import 'package:firebase_crud_app/constants/styles.dart';
import 'package:firebase_crud_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _name = TextEditingController();
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
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                      backgroundColor: Colors.blue,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: () => authController.pickImage(),
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Username',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: Dheight,
                ),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {authController.registerUser(
                    _username.text,
                    _email.text,
                    _password.text,
                    authController.profilePhoto,
                  );
                  Navigator.pushNamed(context, "/HomePage");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: Sbold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have an Account?'),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: buttonColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
