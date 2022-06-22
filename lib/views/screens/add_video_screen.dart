import 'dart:io';

import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/views/screens/confirm_screen.dart';
import 'package:firebase_crud_app/views/screens/confirm_screen_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//main add-photo-video screen
class AddVideoScreen extends StatelessWidget {
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
              videoFile: File(video.path), videoPath: video.path)));
    }
  }

  pickPhoto(ImageSource src, BuildContext context) async {
    final photo = await ImagePicker().pickImage(source: src);
    if (photo != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreenPhoto(
                photoFile: File(photo.path),
                photoPath: photo.path,
              )));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickPhoto(ImageSource.camera, context),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
  }

  showOptionsDialog_2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  /*onPressed: () async{
                    String photo= pickPhoto(ImageSource.gallery, context);
                     },*/
                  onPressed: () => authController.pickImage(),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  //onPressed: () => pickPhoto(ImageSource.camera, context),
                  onPressed: () => authController.pickImage(),

                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () => showOptionsDialog(context),
              child: Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(color: buttonColor),
                child: Center(
                  child: Text(
                    'Add Video',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () => showOptionsDialog_2(context),
              child: Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(color: buttonColor),
                child: Center(
                  child: Text(
                    'Add Photo',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
