import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_app/models/message_utils.dart';


class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  String name;
  String profilePhoto;
  String email;
  String uid;
  DateTime? lastMessageTime;


  User(
      {required this.name,
      required this.profilePhoto,
      required this.email,
      required this.uid,
      this.lastMessageTime,
      });

/*  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      }; */

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        profilePhoto: snapshot['profilePhoto'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        lastMessageTime: Utils.toDateTime(snapshot['lastMessageTime']),
         );
  }



  User copyWith({
    required String uid,
    required String name,
    required String email,
    required String profilePhoto,
    DateTime? lastMessageTime,
   
  }) =>
      User(
        uid: uid,
        name: name,
        email: email,
        profilePhoto: profilePhoto,
        lastMessageTime: lastMessageTime, 
    
      );

  static User fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        profilePhoto: json['profilePhoto'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
       
        
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email':email,
        'profilePhoto': profilePhoto,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime!),
        
        
      };
  
}
