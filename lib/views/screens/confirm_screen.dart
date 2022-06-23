import 'dart:io';

import 'package:firebase_crud_app/controlllers/upload_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  bool click = false;
  String location = 'Null, Press Button';
  String? Address = null;
  String showAdress = 'search';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }


  @override
  void dispose() {
    //
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: VideoPlayer(controller),
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
                      onPressed: () async {

                        click = true;
                        
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
                        labelText: 'Song Name',
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
                    onPressed: () async {

                      if(bool == false){
                        uploadVideoController.uploadVideo(
                        _songController.text,
                        _captionController.text,

                        widget.videoPath,
                        );
                      }
                      else{
                        Position position = await _getGeoLocationPosition();
                        

                        location =
                          'Lat: ${position.latitude} , Long: ${position.longitude}';

                        List<Placemark> placemarks =
                          await placemarkFromCoordinates(position.latitude, position.longitude);
                        Placemark place = placemarks[0];
                        String? temp =
                            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';   
                        print('the temp screen is ' + temp); 
                            
                        
                        GetAddressFromLatLong(position);
                        uploadVideoController.uploadVideo_with_loc(
                        _songController.text,
                        _captionController.text,
                        temp,
                        widget.videoPath,
                        );

                      }
                      
                      
                    },
                    
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