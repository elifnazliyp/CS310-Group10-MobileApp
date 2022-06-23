import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/profile_controller.dart';
import 'package:firebase_crud_app/views/screens/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_crud_app/controlllers/search_controller.dart';
import 'package:firebase_crud_app/views/screens/following_screen.dart';

import 'followers_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String uid;
  //final SearchController searchController = Get.put(SearchController());

   ProfileScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
}) async{
  final serviceId = 'service_gmeqpkt';
  final templateId = 'template_4n6ni29';
  final userId = 'LZvrKJHON3Sd3kaJS';
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id' : serviceId,
      'template_id' : templateId,
      'user_id' : userId,
      'template_params': {
      'username': name,
      'user_email': email,
      'user_subject': subject,
      'user_message': message,
      }
    }),
  );

}


class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName;
    String name2 = name.toString();

    final email = user?.displayName;
    String email2 = email.toString();

    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: widget.uid == authController.user.uid
                ? AppBar(
              backgroundColor: Colors.black12,
              leading: IconButton ( icon: Icon(
                Icons.report,
              ),
              onPressed: () {
                   showDialog<String>(
                        context: context,
                        builder: (BuildContext context)=>AlertDialog(  
                        title: Text('Report User'),  
                        content: const Text(  
                            'You cannot report yourself.'),  
                        actions: <Widget>[  
                          TextButton(  
                            child: const Text('Okay'),  
                            onPressed: () => Navigator.of(context).pop(),

                          ),  
                        ]
                      ),
                    );
                  },
                ),

              actions: [
      
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/ProfileEdit");

                  },
                ),
                SizedBox(height: 5,),

                IconButton(
                  icon: Icon(
                    Icons.bookmark,
                  ),
                  onPressed: () {
                  Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => Bookmark(),
                                    ));

                  },
                )
              ],
              title: Text(
                controller.user['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            )
                : AppBar(
              backgroundColor: Colors.black12,
              leading: IconButton ( icon: Icon(
                Icons.report,
              ),
              onPressed: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context)=> AlertDialog(  
                      title: Text('Report This User?'),  
                      content: const Text(  
                          'Thanks for reporting this user. We will review the post'),  
                      actions: <Widget>[  
                        TextButton(  
                          child: const Text('Cancel'),  
                          onPressed: () => Navigator.of(context).pop(),

                        ),  
                        TextButton(  
                          child: const Text('Okay'),  
                          onPressed:() => sendEmail(
                            name: name2 ,
                            email: email2,
                            subject: ' report user',
                            message: 'Hello, We detected that the user ' + widget.uid + ' reported by the ' + authController.user.uid 
                             + ' It is necessary to investigate the content that disrupts the necessary social structure and integrity on the subject and to process the post in the near future so that it can be deleted if necessary.',) ,
                
                        ),

                      ]
                    ),
                  );
                  
                
                  },
                ),
              title: Text(
                controller.user['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage(
                            controller.user['profilePhoto'],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.user['following'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Center(
                                    child:InkWell(
                                      onTap: (){
                                        //Navigator.pushNamed(context , widget.uid, "/FollowingScreen");
                                        //print("following");
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => FollowingScreen(
                                              myuid: widget.uid,
                                            )));
                                    },

                                        child: Text(
                                          'Following',
                                          style: TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        )

                                    )

                              )

                                )
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              controller.user['followers'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                child: Center(
                                    child:InkWell(
                                        onTap: (){
                                        //Navigator.pushNamed(context , widget.uid, "/FollowingScreen");
                                        //print("following");
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => FollowersScreen(
                                              myuid: widget.uid,
                                            )));
                                    },

                                        child: Text(
                                          'Followers',
                                          style: TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        )

                                    )

                                )

                            )
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              controller.user['likes'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Likes',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 140,
                      height: 47,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (widget.uid == authController.user.uid) {
                              authController.signOut();
                            } else {
                              controller.followUser();
                            }
                          },
                          child: Text(
                            widget.uid == authController.user.uid
                                ? 'Sign Out'
                                : controller.user['isFollowing']
                                    ? 'unfollow'
                                    : 'follow',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    

                    
                      
                    GridView.builder(
                      
                      physics: ScrollPhysics(),
                      itemCount: controller.user['thumbnails'].length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 5
                      ),
                      

                      itemBuilder: (context, index) {
                        
                        
                        String thumbnail =
                          controller.user['thumbnails'][index];
                        return InkWell(
                          child: Container(
                            child: Image.network(
                              thumbnail,
                              fit: BoxFit.cover,
                              
                            ),
                            
                            
                          ),
                          onTap: (){
                            
                              print(controller.user['thumbnails'][index].toString());
                            },
                        );
                      } 
                    ),
                    
                  ],
                ) 
              ],
            )
            ),
          );
        });
        
  }
}