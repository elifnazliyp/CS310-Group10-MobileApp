import 'dart:io';

import 'package:eyesu_project/const.dart';
import 'package:eyesu_project/views/screens/auth/confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoScreen extends StatelessWidget {
  pickVideo(ImageSource src, BuildContext context) async{
    final video = await ImagePicker().pickVideo(source: src);

    if(video != null){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return ConfirmScreen(
          VideoFile: File(video.path),
          VideoPath: video.path,
        );
      }));
    }
  }

  showDialogOption(BuildContext context){
    return showDialog(context: context, builder: (context) => SimpleDialog(
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
              ),
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: () => pickVideo(ImageSource.camera, context),
          child: Row(
            children: [
              Icon(Icons.camera_alt_outlined,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Camera', 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
              ),
            ],
          ),
          
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.cancel),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Cancel', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
              ),
            ],
          ),
        )
      ],
    ),
    
    
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOption(context),
          child: Container(
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            width: 200,
            height: 50,
            child: Center(
              child: 
              Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
              )
            ),
          ),
          
        )
      ),

    );
  }
}