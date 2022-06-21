import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_crud_app/controlllers/search_controller.dart';
import 'package:firebase_crud_app/views/screens/following_screen.dart';

import 'followers_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  //final SearchController searchController = Get.put(SearchController());

   ProfileScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
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
              leading: Icon(
                Icons.person,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/ProfileEdit");

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
              leading: Icon(
                Icons.person,
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