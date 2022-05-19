import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/colors.dart';
import '../widgets/text_field_input.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  
  
  
  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: 
      Container(
        padding:const EdgeInsets.symmetric(horizontal:32),
        width: double.infinity,
        child: Column(
          

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child:Container(),flex:2),
            SvgPicture.asset('assets/ic_instagram.svg',color: primaryColor, height: 64,),

            const SizedBox(height:34),
            Stack(
              children:[
                const CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage('https://i1.sndcdn.com/avatars-000023440200-orwnp2-t500x500.jpg'),
                ),
                Positioned(
                  bottom: -10,
                  left: 20,

                  child: IconButton(


                    onPressed:(){}, 
                    icon: const Icon(
                      Icons.add_a_photo,),
                  ),
                ),
              ]
            ),
            const SizedBox(height:24),

            TextFieldInput(textEditingController: _usernameController, 
            hintText: 'Enter Your Username', 
            textInputType: TextInputType.text),




            const SizedBox(height:24),
            TextFieldInput(textEditingController: _emailController, 
            hintText: 'Enter Your Email', 
            textInputType: TextInputType.emailAddress),

            const SizedBox(height:24),
            TextFieldInput(textEditingController: _passwordController, 
            hintText: 'Enter Your Password', 
            textInputType: TextInputType.text,
            isPass:true),
            const SizedBox(height:24),
            


            TextFieldInput(textEditingController: _bioController, 
            hintText: 'Enter Your Bio', 
            textInputType: TextInputType.text),
            const SizedBox(height:64),




            InkWell(
              child: 
              Container(alignment:Alignment.center,
                child: const Text('Log in'),
                width:double.infinity,
                padding:const EdgeInsets.symmetric(vertical:12),
                decoration:const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    )
                ),
                color:purpleColor,
              )
          ),
            ),
          const SizedBox(
            height: 12,

          ),
          Flexible(child:Container(),flex:2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Container(
                child:const Text("Don't have an account???:("),
                padding: const EdgeInsets.symmetric(
                  vertical:8,
                  ),
                ),
                GestureDetector(
                  onTap:() {},
                  child: Container(
                    child: const Text(
                      "Sign up",
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical:8,
                      ),
                    ),
                ),
            ],
          ),
          
      ],

      ),)
    ),);
  }
}