import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final String postUrl;
  final datePublished;
  final String profImage;
  final likes;

  Post(
      {required this.description,
      required this.uid,
      required this.postId,
      required this.username,
      required this.datePublished,
      required this.profImage,
      required this.likes,
      required this.postUrl});

  Map<String, dynamic> toJson() => {
        "description": description,
        "username": username,
        "uid": uid,
        "postUrl": postUrl,
        "postId": postId,
        "profImage": profImage,
        "datepublished": datePublished,
        "likes": likes
      };

  static Post fromSnap(DocumentSnapshot? snap) {
    var snapshot = snap?.data() as Map<String, dynamic>;
    return Post(
        description: snapshot['description'],
        uid: snapshot['uid'],
        postUrl: snapshot['postUrl'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        likes: snapshot['likes'],
        profImage: snapshot['profImage']);
  }
}
