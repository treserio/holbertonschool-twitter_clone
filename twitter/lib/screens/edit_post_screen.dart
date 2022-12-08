import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/widgets/all.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/flat_button.dart';
import '../providers/all.dart';
import '../models/all.dart';

class EditPostScreen extends StatelessWidget {
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();

  EditPostScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserData activeUserData = Provider.of<AuthState>(context).activeUserData!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black87,
        title: Center(
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(activeUserData.avatar),
                  ),
                )
              ),
              const Expanded(
                flex: 9,
                child: Text(
                  'Post it!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: FlatButton(
              onPressed: () async {
                try {
                  DocumentReference<Post?> postInfo = await postRef.add(
                    Post(
                      userKey: activeUserData.key,
                      postText: _postController.text,
                      createdAt: Timestamp.now(),
                      hashtags: _hashtagController.text.split(' '),
                    )
                  );
                  postRef.doc(postInfo.id).update({'key': postInfo.id});
                } catch (e) {
                  print(e);
                }
              },
              label: 'Squack!',
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _postController,
              maxLength: 500,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: 'Get your Squack on!',
              ),
            ),
            EntryField(
              controller: _hashtagController,
              hint: 'Comma Seperated Hashtags',
            ),
          ],
        ),
      ),
    );
  }
}
