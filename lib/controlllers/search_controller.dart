import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  final Rx<List<Video>> _searchedVideos = Rx<List<Video>>([]);

  List<User> get searchedUsers => _searchedUsers.value;
  List<Video> get searchedVideos => _searchedVideos.value;
  

  searchUser(String typeUser) async {
    _searchedUsers.bindStream(
      firebaseStore
          .collection('users')
          .where('name', isEqualTo: typeUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> retVal = [];
          for (var elem in query.docs) {
            retVal.add(User.fromSnap(elem));
          }
          return retVal;
        },
      ),
    );
  }

    searchTopics(String typeTopic) async {
    _searchedVideos.bindStream(
      firebaseStore
          .collection('videos')
          .where('caption', isEqualTo: typeTopic)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Video> retVal = [];
          for (var elem in query.docs) {
            retVal.add(Video.fromSnap(elem));
          }
          return retVal;
        },
      ),
    );
  }
}
