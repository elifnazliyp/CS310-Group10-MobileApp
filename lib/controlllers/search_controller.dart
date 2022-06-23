import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  final Rx<List<Video>> _searchedVideos = Rx<List<Video>>([]);
  final Rx<List<User>> _searchedFollowing = Rx<List<User>>([]);
  final Rx<List<User>> _searchedFollowers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;
  List<Video> get searchedVideos => _searchedVideos.value;
  List<User> get searchedFollowing => _searchedFollowing.value;
  List<User> get searchedFollowers => _searchedFollowers.value;


  searchUser(String typeUser) async {
    //print("*********************1");
    _searchedUsers.bindStream(
      firebaseStore
          .collection('users')
          .where('name', isEqualTo: typeUser)
          .snapshots()
          .map(
            (QuerySnapshot query) {
          List<User> retVal = [];
          for (var elem in query.docs) {
            //print("*********************");
            //print(User.fromSnap(elem).name);
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

  searchFollowings(String userId) async {
    print("searchFollowings has been called");
    var followingDoc = await firebaseStore
        .collection('users')
        .doc(userId)
        .collection('following')
        .get();
    List<String> followingList = [];
    for (var elem in followingDoc.docs) {
      followingList.add(elem['id'].toString());
    }
    _searchedFollowing.bindStream(
      firebaseStore
          .collection('users')
          .snapshots()
          .map(
            (QuerySnapshot query) {
          List<User> retVal = [];
          for (var elem in query.docs) {
            //print("*********************");
            //print((User.fromSnap(elem).uid));
            if (followingList.contains(User.fromSnap(elem).uid))
            {
              //print((User.fromSnap(elem).uid));
              retVal.add(User.fromSnap(elem));
            }
          }
          return retVal;
        },
      ),
    );
  }

  searchFollower(String userId) async {
     print("searchFollower has been called");
    var followingDoc = await firebaseStore
        .collection('users')
        .doc(userId)
        .collection('followers')
        .get();
    List<String> followingList = [];
    for (var elem in followingDoc.docs) {
      followingList.add(elem['id'].toString());
    }
    _searchedFollowers.bindStream(
      firebaseStore
          .collection('users')
          .snapshots()
          .map(
            (QuerySnapshot query) {
          List<User> retVal = [];
          for (var elem in query.docs) {
            if (followingList.contains(User.fromSnap(elem).uid.toString())) {
              retVal.add(User.fromSnap(elem));
            }
          }
          return retVal;
        },
      ),
    );
  }

   searchBookmark(String typeUserId) async {
    _searchedVideos.bindStream(
      firebaseStore
          .collection('videos')
          .where('isSaved', arrayContains: typeUserId)
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

    searchHashtag(String typeHashtag) async {
    _searchedVideos.bindStream(
      firebaseStore
          .collection('videos')
          .where('topics', arrayContains: typeHashtag)
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

    searchLocation(String typeLocation) async {
    _searchedVideos.bindStream(
      firebaseStore
          .collection('videos')
          .where('Address', isLessThanOrEqualTo: typeLocation)
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
