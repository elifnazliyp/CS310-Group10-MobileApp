
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/views/screens/chat_page.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:firebase_crud_app/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<User> users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Messages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      child: IconButton(
                        onPressed: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    )),
                        icon: Icon(Icons.arrow_back),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(user: users[index]),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(user.profilePhoto),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
}