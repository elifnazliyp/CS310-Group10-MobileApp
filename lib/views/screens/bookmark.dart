import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/search_controller.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:firebase_crud_app/views/screens/profile_screen.dart';
import 'package:firebase_crud_app/views/screens/single_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bookmark extends StatefulWidget {
 
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {

  final SearchController searchController = Get.put(SearchController());
  @override
  void initState() {
    super.initState();
    searchController.searchBookmark(FirebaseAuth.instance.currentUser!.uid);
    //print(searchController.searchedFollowers.length);
  }

  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
              title: Text("BOOKMARKS"),
              backgroundColor: Colors.red,

            ),
        body: searchController.searchedVideos.isEmpty
          ? Center(
              child: Text(
                'No Bookmark',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          :GridView.builder(
            itemCount: searchController.searchedVideos.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
              itemBuilder: (context, index) {
              Video video = searchController.searchedVideos[index];
              //String thumbnail = video.thumbnail.[index];
              return InkWell(
                child: Container(
                  child: Image(
                    image:
                    NetworkImage(video.thumbnail),
                    fit: BoxFit.cover,
                    
                  ),
                ),
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => single_Video(item_type: video),
                  ),
                   );

                  Navigator.pushNamed(context,  "/SingleVideo");
                  print(video.videoUrl);
                  
                },
              );
            }
          )
      );
    });   
  }
}
