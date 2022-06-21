import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/controlllers/profile_controller.dart';
import 'package:firebase_crud_app/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_crud_app/controlllers/search_controller.dart';
import 'package:firebase_crud_app/views/screens/following_screen.dart';

import '../../models/user.dart';

class FollowersScreen extends StatefulWidget {
  final String myuid;
  //final SearchController searchController = Get.put(SearchController());

  FollowersScreen({Key? key, required this.myuid}) : super(key: key);
  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final SearchController searchController = Get.put(SearchController());
  @override
  void initState() {
    super.initState();
    searchController.searchFollower(widget.myuid);
    //print(searchController.searchedFollowers.length);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Followers")
              

            ),
            body:ListView.builder(
                itemCount: searchController.searchedFollowers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedFollowers[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            uid: user.uid,
                          )));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }),
          );
        });

  }
}