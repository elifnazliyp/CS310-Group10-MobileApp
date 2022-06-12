import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/video_controller.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:firebase_crud_app/views/screens/comment_screen.dart';
import 'package:firebase_crud_app/views/screens/widgets/circle_animation.dart';
import 'package:firebase_crud_app/views/screens/widgets/video_player_item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class single_Video extends StatelessWidget {
  final Video item_type;

  single_Video({Key? key, required this.item_type}) : super(key: key);

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
    final storageRef = FirebaseStorage.instance.ref();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: videoController.videoList.length,
          scrollDirection: Axis.vertical,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(videoUrl: item_type.videoUrl),
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
                                  item_type.caption,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.music_note,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      item_type.songName,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
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
                  margin: EdgeInsets.only(top: size.height / 5),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          final desertRef = storageRef.child(item_type.videoUrl);

                          await desertRef.delete();


                          FirebaseStorage.instance.refFromURL(item_type.videoUrl).delete();
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
