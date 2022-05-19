import 'dart:ffi';
import 'dart:io';


import 'package:eyesu_project/models/user.dart' as model;
import 'package:eyesu_project/views/screens/auth/home_screen.dart';
import 'package:eyesu_project/views/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../const.dart';





class AuthController extends GetxController{
  static AuthController instance = Get.find();
  //upload picked image to storage

  //pick image fro gallery

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;


  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialState);
  }

  _setInitialState(User? user){
    if(user == null){
      Get.offAll(LoginScreen());
    } else{
      Get.offAll(HomeScreen());
    }
  }

  void pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage != null){
      Get.snackbar('Profile Photo', 'Image Uploaded');
    }

    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }
  
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
      String username,String email, String password, File? image)async{
    try {
      if(username.isNotEmpty && 
      email.isNotEmpty && 
      password.isNotEmpty && 
      image != null) {
      // we want to save the user to auth and to firebase firestore
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

      String downloadurl = await _uploadImageToStorage(image);
      //firestore.collection('users').doc(cred.user!.uid).set
      model.User user= model.User(
        name: username, 
        profilePhoto: downloadurl, 
        email: email, 
        uid: cred.user!.uid);
        await firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

      } else{
        Get.snackbar('Error creating account', 'Please enter all fields');
      }

    } catch (e) {
      Get.snackbar('Error Creating Account',e.toString());
    }
  }

  void loginUser(String email, String password) async{
    try {
      if(email.isNotEmpty && password.isNotEmpty){
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        print('logged in already');
        Get.offAll(HomeScreen());

      } else{
        Get.snackbar('Error logging in', 'Please enter all fieds');
      }
    } catch (e) {
      Get.snackbar('Error logging in', e.toString());
    }
  }


}