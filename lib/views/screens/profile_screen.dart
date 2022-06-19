import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/profile_controller.dart';
import 'package:firebase_crud_app/views/screens/single_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  late TransformationController controller2;
  TapDownDetails? tapDownDetails;
  @override
  
  
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
    controller2 = TransformationController();
  }
  void dispose () {
    controller2.dispose();
    super.dispose();
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
          final user = FirebaseAuth.instance.currentUser;
          final name = user?.displayName;
          String name2 = name.toString();
          String profilepic = controller.user['profilePhoto'];
          return Scaffold(
            appBar: AppBar(
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
                name2,
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
                          GestureDetector(
                            onDoubleTapDown: (details)=> tapDownDetails= details,
                            onDoubleTap: () {
                              final position =tapDownDetails!.localPosition;
                              final double scale =3;
                              final x = -position.dx * (scale-1);
                              final y = -position.dy * (scale-1);
                              final zoomed = Matrix4.identity()
                              ..translate(x,y)
                              ..scale(scale);
                              final value = controller2.value.isIdentity() ? zoomed: Matrix4.identity();
                              controller2.value =value;
                            },
                            child: InteractiveViewer(
                              clipBehavior: Clip.none,
                              transformationController: controller2,
                              panEnabled: false,
                              scaleEnabled: false,
                              boundaryMargin: EdgeInsets.all(100),
                              minScale: 0.5,
                              maxScale: 2,
                              
                              
                              
                              child: 
                            
                                Image.network(
                                  
                                  profilepic,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                            ),
                          ),
                          /*CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage(
                              controller.user['profilePhoto'],
                            ),
                          ),*/
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
                            Text(
                              'Following',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                            Text(
                              'Followers',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                            
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => single_Video(item_type: controller.user['thumbnails'][index]),
                              ),
                            );

                              Navigator.pushNamed(context,  "/SingleVideo");
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