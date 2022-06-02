import 'package:firebase_crud_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
          'assets/Welcome.png',
          fit: BoxFit.cover,
        )),
        const Center(),
        Container(
          margin: const EdgeInsets.only(left: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 450,
                ),
                child: Text(
                  'EYESU.',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 350,
                child: Text(
                  "Don't forget to share videos and have fun!!!",
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: const Color(0xffBABABA),
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                // color: Colors.green,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      
                    ),
                    child:  Text(
                      'Log in',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, "/LoginScreen");
                    },
                  ),

          

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      
                    ),
                    child:  Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, "/SignUpScreen");
                    },
                  ),
                    
                    
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
