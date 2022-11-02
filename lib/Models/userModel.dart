import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String skills;
  final String address;
  final String dob;
  final String mobileNumber;
  final bool vendor;
  //final List followers;
  //final List following;

  const User({
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.email,
    required this.skills,
    required this.address,
    required this.dob,
    required this.mobileNumber,
    required this.vendor,
    //required this.followers,
    //required this.following
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      skills: snapshot["skills"],
      address: snapshot["address"],
      dob: snapshot["dob"],
      mobileNumber: snapshot["mobile number"],
      vendor: snapshot["vendor"],
      //followers: snapshot["followers"],
      //following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "skills": skills,
        "address": address,
        "dob": dob,
        "mobile number": mobileNumber,
        "vendor": vendor,
        //"followers": followers,
        //"following": following,
      };
}
