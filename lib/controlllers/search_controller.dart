import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typeUser) async {
    _searchedUsers.bindStream(
      firebaseStore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typeUser)
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
}
