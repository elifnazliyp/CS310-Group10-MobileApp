import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/models/video.dart';
import 'package:firebase_crud_app/models/user.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firebaseStore
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        print("****************");
        retVal.add(
          Video.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc =
        await firebaseStore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firebaseStore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
    await firebaseStore.collection('videos').doc(id).update({
      'likes': FieldValue.arrayUnion([uid])
    });}

  }

  bookmarkVideo(String id1) async {
    DocumentSnapshot doc =
        await firebaseStore.collection('videos').doc(id1).get();
    var uid = authController.user.uid;
    if ((doc.data() as dynamic)['isSaved'].contains(uid)) {
      await firebaseStore.collection('videos').doc(id1).update({
        'isSaved': FieldValue.arrayRemove([uid])
      });
    } else {
    await firebaseStore.collection('videos').doc(id1).update({
      'isSaved': FieldValue.arrayUnion([uid])
    });
    }
  }

}
