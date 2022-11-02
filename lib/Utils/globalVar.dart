import 'package:dreams/screens/currUserprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dreams/screens/screens.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  //const Text('notifications'),
  CurrUserProfile(uid: FirebaseAuth.instance.currentUser!.uid)
];
