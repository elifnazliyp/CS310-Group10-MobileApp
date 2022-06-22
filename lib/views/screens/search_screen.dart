import 'dart:ui';

import 'package:firebase_crud_app/controlllers/search_controller.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:firebase_crud_app/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //
  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
            icon: Icon(Icons.topic),
            onPressed:() {
            Navigator.pushNamed(context, "/TopicSearch");
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
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
          actions: [
            IconButton(
            icon: Icon(Icons.search_off_sharp),
            onPressed:() {
            Navigator.pushNamed(context, "/HashtagScreen");
          } ,),
          ],
        ),
        body: searchController.searchedUsers.isEmpty
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
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
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
