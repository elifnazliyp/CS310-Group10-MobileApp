import 'dart:ui';

import 'package:firebase_crud_app/controlllers/search_controller.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:firebase_crud_app/views/screens/profile_screen.dart';
import 'package:firebase_crud_app/views/screens/single_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashtagScreen extends StatefulWidget {
  @override
  _HashtagScreenState createState() => _HashtagScreenState();
}

class _HashtagScreenState extends State<HashtagScreen> {

  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed:() {
            Navigator.pushNamed(context, "/SearchScreen");
          } ,),
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onFieldSubmitted: (value) => searchController.searchHashtag(value),
          ),
        ),
        body: searchController.searchedVideos.isEmpty
          ? Center(
              child: Text(
                'Find your destiny',
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
