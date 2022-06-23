import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/profile_controller.dart';
import 'package:firebase_crud_app/controlllers/video_controller.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:firebase_crud_app/views/screens/comment_screen.dart';
import 'package:firebase_crud_app/views/screens/widgets/circle_animation.dart';
import 'package:firebase_crud_app/views/screens/widgets/video_player_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class single_Video2 extends StatelessWidget {
  final String item_type;
  final String id;
  final String name;
  
  

  single_Video2({Key? key, required this.item_type, required this.id, required this.name}) : super(key: key);

  ProfileController controller = Get.put(ProfileController());
  final VideoController videoController = Get.put(VideoController());

  buildProfie(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(profilePhoto)),
            ),
          )
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.white],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                profilePhoto,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    //final storageRef = FirebaseStorage.instance.ref();

    //final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          scrollDirection: Axis.vertical,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          itemBuilder: (context, index) {
            //final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: item_type),
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    ))
                  ],


                
                ),
                

                
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          
                          print('the id is ' + id);
                          await firebaseStore.collection('videos').doc(id).delete();
                          
                          Navigator.pop(context);
                        },
                        
                        child: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 20, color: Colors.white),
                      ) 
                      
                    ], 
                  ),
                ), 

                /*Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.report,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                  ],
                ),*/

                
              ],
            );
          },
          
        );
      }),
    );
  }
}
