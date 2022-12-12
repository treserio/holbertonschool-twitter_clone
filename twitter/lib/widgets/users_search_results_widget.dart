import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersSearchResult extends StatelessWidget {
  final UserData user;
  final UserData activeUser;
  final Function setState;

  const UsersSearchResult({
    super.key,
    required this.user,
    required this.activeUser,
    required this.setState,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(
      foregroundImage: NetworkImage(user.avatar),
    ),
    title: Text(
      user.name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      '@${user.userName}',
    ),
    trailing: user.followersList.contains(activeUser.key) ?
    TextButton(
      onPressed: () async {
        // apply changes
        user.followersList.remove(activeUser.key);
        user.followers -= 1;
        activeUser.followingList.remove(user.key);
        activeUser.following -= 1;
        // add updates as a batch update
        var db = FirebaseFirestore.instance;
        var batch = db.batch();
        var postRef = db.collection('userData')
          .doc(user.key);
        postRef.update({
            'followersList': user.followersList,
            'followers': user.followers,
          });
        var activeRef = db.collection('userData')
          .doc(activeUser.key);
        activeRef.update({
          'followingList': activeUser.followingList,
          'following': activeUser.following,
        });
        // Commit the batch
        batch.commit();
        // update the local state to display changes
        setState((() => {}));
      },
      style: TextButton.styleFrom(
        // fixedSize: const Size.fromHeight(0.5),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        minimumSize: const Size(30, 30),
      ),
      child: const Text(
        'Unfollow',
        style: TextStyle(fontSize: 18),
      ),
    )
    : TextButton(
      onPressed: () async {
        // apply changes
        user.followersList.add(activeUser.key);
        user.followers += 1;
        activeUser.followingList.add(user.key);
        activeUser.following += 1;
        // add updates as a batch update
        var db = FirebaseFirestore.instance;
        var batch = db.batch();
        var postRef = db.collection('userData')
          .doc(user.key);
        postRef.update({
            'followersList': user.followersList,
            'followers': user.followers,
          });
        var activeRef = db.collection('userData')
          .doc(activeUser.key);
        activeRef.update({
          'followingList': activeUser.followingList,
          'following': activeUser.following,
        });
        // Commit the batch
        batch.commit();
        // update the local state to display changes
        setState((() => {}));
      },
      style: TextButton.styleFrom(
        // fixedSize: const Size.fromHeight(0.5),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        minimumSize: const Size(30, 30),
      ),
      child: const Text(
        'Follow',
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}
