import 'package:firebase_crud_app/main.dart';
import 'package:flutter/material.dart';



class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({Key? key}) : super(key: key);

  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  PageController pc = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: pc,
        children: [Page1(pc), Page2(pc), Page3(pc, context)],
      ),
    );
  }
}

Widget Page1(PageController pc) {
  return Container(
    height: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage("assets/sabancı.jpeg"),
      fit: BoxFit.fill,
    )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                  child: Container(
                width: 300,
                child: Image(
                  image: AssetImage("assets/sabancilogo.jpeg"),
                  fit: BoxFit.cover,
                ),
              )),
              SizedBox(
                height: 250,
              ),
              Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "Welcome to EYESU!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1.0),
                      ))),
              SizedBox(
                height: 100,
              ),
              Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "We are here to learn and have fun ;)",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1.0),
                      ))),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      pc.jumpToPage(1);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    ),
  );
}

Widget Page2(PageController pc) {
  return Container(
    height: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage("assets/study.jpeg"),
      fit: BoxFit.cover,
    )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                  child: Container(
                width: 300,
                child: Image(
                  image: AssetImage("assets/sabancilogo.jpeg"),
                  fit: BoxFit.fill,
                ),
              )),
              SizedBox(
                height: 250,
              ),
              Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "You can interact with the users who are taking the same classes for project groups, exam dates and homeworks!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1.0),
                      ))),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      pc.jumpToPage(0);
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      pc.jumpToPage(2);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    ),
  );
}

Widget Page3(PageController pc, BuildContext context) {
  return Container(
    height: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage("assets/club.jpeg"),
      fit: BoxFit.cover,
    )),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                  child: Container(
                width: 300,
                child: Image(
                  image: AssetImage("assets/sabancilogo.jpeg"),
                  fit: BoxFit.fill,
                ),
              )),
              SizedBox(
                height: 250,
              ),
              Center(
                  child: Container(
                      color: Colors.white,
                      child: Text(
                        "You can get notified for club activities and see what is going in both video and photo forms!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            height: 1.2,
                            letterSpacing: 1.0),
                      ))),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      pc.jumpToPage(1);
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/Welcome");
                        isRunBefore= true;
                      },
                      child: Text(
                        "Get Started!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            height: 1.2,
                            letterSpacing: 1.0),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    ),
  );
}