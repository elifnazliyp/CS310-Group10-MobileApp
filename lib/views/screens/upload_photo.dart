import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_crud_app/views/screens/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/views/screens/confirm_screen.dart';
import 'package:firebase_crud_app/views/screens/confirm_screen_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoScreen extends State {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  get snapshotEvents => null;

  Future upladFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    //ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Upload File'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickedFile != null)
              Expanded(
                  child: Container(
                color: Colors.blue,
                child: Image.file(
                  File(pickedFile!.path!),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )),
          ],
        )),
      );
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: /*UploadTask?.*/ snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;

          return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                      child: Text('${(100 * progress).roundToDouble()}%',
                          style: const TextStyle(color: Colors.white)))
                ],
              ));
        } else {
          return const SizedBox(height: 50);
        }
      });
}
