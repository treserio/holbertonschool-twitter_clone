// import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter/screens/edit_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widgets/all.dart';
import '../providers/all.dart';
import '../models/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Icon logoutIcon = const Icon(
    Icons.logout
  );

  Future<List<Post>> fetchRecentPosts() async =>
    await FirebaseFirestore
      .instance
      .collection('posts')
      .orderBy('createdAt')
      .limit(20)
      .get()
      .then((s) {
        List<Post> result = [];
        for (var doc in s.docs) {
          result.add(Post.fromJson(doc.data()));
        }
        return result;
      });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: Colors.black87,
      title: const Center(
        child: Text(
          'Home',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          )
        )
      ),
      actions: [
        Consumer<AppState>(
          builder: (_, state, __) => MouseRegion(
            onEnter: (_) {
              logoutIcon = Icon(
                Icons.logout,
                color: Colors.blue.shade800,
              );
              setState(() {});
            },
            onExit: (_) {
              logoutIcon = const Icon(Icons.logout);
              setState(() {});
            },
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                state.setpageIndex = 0;
                // ignore: use_build_context_synchronously
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: logoutIcon,
              ),
            ),
          ),
        ),
      ],
    ),
    drawer: const SideBarMenu(),
    bottomNavigationBar: const BottomMenuBar(),
    body: FutureBuilder<List<Post>>(
      future: fetchRecentPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => PostWidget(post: snapshot.data![index])
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ),
    floatingActionButton: FloatingActionButton(
      mini: true,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          EditPostScreen()
        ),
      ).then((_) => setState(() => {})),
      child: const Icon(
        Icons.add
      ),
    ),
  );
}
