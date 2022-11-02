import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String location;
  final String contact;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final double geoLongitude;
  final double geoLatitude;

  const Post({
    required this.description,
    required this.location,
    required this.contact,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.geoLongitude,
    required this.geoLatitude,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        description: snapshot["description"],
        location: snapshot["location"],
        contact: snapshot["contact"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        geoLongitude: snapshot['geoLongitude'],
        geoLatitude: snapshot['geoLatitude']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "location": location,
        "contact": contact,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'geoLongitude': geoLongitude,
        'geoLatitude': geoLatitude
      };
}
