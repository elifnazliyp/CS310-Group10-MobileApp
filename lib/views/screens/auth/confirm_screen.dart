import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File VideoFile;
  final String VideoPath;

  const ConfirmScreen({super.key, required this.VideoFile, required this.VideoPath});
  

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.VideoFile);
    });

    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.5,
              child: VideoPlayer(controller),
            ),

            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.music_note),
                hintText: 'Song Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.captions_bubble),
                hintText: 'Caption',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              onPressed: () {},
               child: Text('Share')),

          ],
        ),
      )
    );
    
  }
}