import 'dart:io';


import 'package:eyesu_project/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../const.dart';





class AuthController extends GetxController{
  //upload picked image to storage
  
  Future<String> _uploadImageToStorage(File image) async{
    Reference ref =firebaseStorage
    .ref()
    .child('profilePics')
    .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;

  }

  //registering users
  void registerUser(
      String username,String email, String password, File image)async{
    try {
      if(username.isNotEmpty && 
      email.isNotEmpty && 
      password.isNotEmpty && 
      image != null) {
      // we want to save the user to auth and to firebase firestore
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

      String downloadurl = await _uploadImageToStorage(image)
      //firestore.collection('users').doc(cred.user!.uid).set
      model.User user= model.User(
        name: username, 
        profilePhoto: downloadurl, 
        email: email, 
        uid: cred.user!.uid);
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

      } 

    } catch (e) {
      Get.snackbar('Error Creating Account',e.toString());
    }
  }


}