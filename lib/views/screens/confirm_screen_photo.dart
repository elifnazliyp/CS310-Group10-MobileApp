import 'dart:io';

import 'package:firebase_crud_app/controlllers/upload_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreenPhoto extends StatefulWidget {
  final File photoFile;
  final String photoPath;

  const ConfirmScreenPhoto(
      {Key? key, required this.photoFile, required this.photoPath})
      : super(key: key);
  @override
  State<ConfirmScreenPhoto> createState() => _ConfirmScreenPhotoState();
}

class _ConfirmScreenPhotoState extends State<ConfirmScreenPhoto> {
  
  late VideoPlayerController controller;
  
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  //String get photopath => null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //final String file = photoPath;
    });
  }

  selectPhoto(String photoPath){

  }

  /*@override
  void dispose() {
    //
    super.dispose();
    controller.dispose();
  }*/

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),/*Image.network(photopath,
                              fit: BoxFit.cover,
                              
                            ),/VideoPlayer(controller),*/
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: ElevatedButton(
                      
                      child: Text('Share Your Location'),
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      )
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _songController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Photo Name',
                        prefixIcon: Icon(Icons.music_note),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _captionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Caption',
                        prefixIcon: Icon(Icons.closed_caption),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => uploadVideoController.uploadPhoto(
                        _songController.text,
                        _captionController.text,
                        widget.photoPath),
                    child: Text('Share'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
