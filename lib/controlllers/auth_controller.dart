import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/models/user.dart' as model;
import 'package:firebase_crud_app/views/auth/login_screen.dart';
import 'package:firebase_crud_app/views/screens/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.off(() => LoginScreen());
    } else {
      Get.off(() => HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', 'Nice');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }
  //upload to firebaseStorage

  Future<String> _uploadToStorage(File image) async {
    Reference ref =
        firebaseStorage.ref('profilePics').child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save user to auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
        );
        await firebaseStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error Creating Account', 'Pleasse Enter all Fields');
      }
    } catch (e) {
      Get.snackbar('Error Creating Accoung', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('log success');
      } else {
        Get.snackbar('Error Signin', 'Fields must not be empty');
      }
    } catch (e) {
      Get.snackbar('Error Signin', e.toString());
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  //sould update?

  void updateUsername(String username) async{


    try {
      
      
    
      if(username.isNotEmpty){
        await user.updateDisplayName(username);

      } else{
        Get.snackbar('Error updating', 'Please enter all fieds');
      }
    } catch (e) {
      Get.snackbar('Error updating', e.toString());
    }
  }
  void updatePassword(String password) async{


    try {

      if(password.isNotEmpty){
        await user.updatePassword(password);

      } else{
        Get.snackbar('Error updating', 'Please enter all fieds');
      }
    } catch (e) {
      Get.snackbar('Error updating', e.toString());
    }
  }
  void updatePhoto(File? image) async{

    String downloadUrl = await _uploadToStorage(image!);
    try {

      if(image!=null){
        await user.updatePhotoURL(downloadUrl);

      } else{
        Get.snackbar('Error updating', 'Please enter all fieds');
      }
    } catch (e) {
      Get.snackbar('Error updating', e.toString());
    }
  }
}

