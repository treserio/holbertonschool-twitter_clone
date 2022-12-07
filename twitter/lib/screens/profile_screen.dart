import 'dart:ui';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widgets/all.dart';
import '../providers/all.dart';
import '../models/user_data.dart';

class ProfileScreen extends StatefulWidget {
  final UserData? postUser;

  const ProfileScreen({
    super.key,
    required this.postUser,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var menuIcon = const Icon(
    Icons.more_vert,
    color: Colors.grey,
  );

  var yearMonth = DateFormat('MMMM y');

  @override
  Widget build(BuildContext context) => Consumer<AuthState>(
    builder: (_, state, __) => Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // title: Image.network(widget.postUser!.coverImgUrl),
        // centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: MouseRegion(
              onEnter: (_) {
                menuIcon = Icon(
                  Icons.more_vert,
                  color: Colors.blue.shade800,
                );
                setState(() {});
              },
              onExit: (_) {
                menuIcon = const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                );
                setState(() {});
              },
              child: GestureDetector(
                  onTap: () => print('menuIcon'),
                  child: menuIcon,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.postUser!.coverImgUrl),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150, left: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 5,
                        color: Colors.white
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      foregroundImage: NetworkImage(widget.postUser!.imageUrl),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.8, -1),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 210),
                    child: widget.postUser!.key == state.authState.currentUser!.uid ?
                      TextButton(
                        onPressed: () => print('Edit Profile'),
                        style: ButtonStyle(
                          side: MaterialStateProperty.resolveWith<BorderSide>(
                            (states) => BorderSide(
                              color: Colors.blue.shade800,
                              width: 3,
                            )),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.blue.shade100),
                          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) =>
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    // If the current user is in the followers list of the poster...
                    : widget.postUser!.followersList.contains(state.authState.currentUser!.uid) ?
                      Wrap(
                      // MAIL ICON
                          spacing: 10,
                          children: [
                            Container(
                              // width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue.shade800,
                                  width: 3,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.mail_outline,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),
                            // UNFOLLOW BUTTON
                            TextButton(
                              onPressed: () async {
                                // apply changes
                                widget.postUser!.followersList.remove(state.activeUserData!.key);
                                widget.postUser!.followers -= 1;
                                state.activeUserData!.followingList.remove(widget.postUser!.key);
                                state.activeUserData!.following -= 1;
                                // add updates as a batch update
                                var db = FirebaseFirestore.instance;
                                var batch = db.batch();
                                var postRef = db.collection('userData')
                                  .doc(widget.postUser!.key);
                                postRef.update({
                                    'followersList': widget.postUser!.followersList,
                                    'followers': widget.postUser!.followers,
                                  });
                                var activeRef = db.collection('userData')
                                  .doc(state.activeUserData!.key);
                                activeRef.update({
                                  'followingList': state.activeUserData!.followingList,
                                  'following': state.activeUserData!.following,
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
                          ]
                        )
                    : Wrap(
                      // MAIL ICON
                        spacing: 10,
                        children: [
                          Container(
                            // width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue.shade800,
                                width: 3,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.mail_outline,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                          // FOLLOW BUTTON
                          TextButton(
                            onPressed: () async {
                              // apply changes
                              widget.postUser!.followersList.add(state.activeUserData!.key);
                              widget.postUser!.followers += 1;
                              state.activeUserData!.followingList.add(widget.postUser!.key);
                              state.activeUserData!.following += 1;
                              // add updates as a batch update
                              var db = FirebaseFirestore.instance;
                              var batch = db.batch();
                              var postRef = db.collection('userData')
                                .doc(widget.postUser!.key);
                              postRef.update({
                                  'followersList': widget.postUser!.followersList,
                                  'followers': widget.postUser!.followers,
                                });
                              var activeRef = db.collection('userData')
                                .doc(state.activeUserData!.key);
                              activeRef.update({
                                'followingList': state.activeUserData!.followingList,
                                'following': state.activeUserData!.following,
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
                          )
                        ]
                      ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                widget.postUser!.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 25),
              child: Text(
                '@${widget.postUser!.userName}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()..color = Colors.grey.shade600,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Text(
                widget.postUser!.bio,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()..color = Colors.grey.shade800,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Wrap(
                spacing: 10,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    'Somewhere out there beneath the pale moonlight',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      foreground: Paint()..color = Colors.grey.shade700,
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25),
              child: Wrap(
                spacing: 10,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    'Joined ${yearMonth.format(
                      widget.postUser!.creationTime.toDate()
                    )}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      foreground: Paint()..color = Colors.grey.shade700,
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25),
              child: Wrap(
                spacing: 30,
                children: [
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(
                        '${widget.postUser!.followers}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          foreground: Paint()..color = Colors.grey.shade700,
                        )
                      ),
                    ]
                  ),
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(
                        '${widget.postUser!.following}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          foreground: Paint()..color = Colors.grey.shade700,
                        )
                      ),
                    ]
                  ),
                ],
              ),
            ),
            ListView(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              children: const [
                Divider(),
                PostWidget(userKey: 'rglSlBYoMZV9NlwKrAGCJDGxTKo2'),
                PostWidget(userKey: 'rglSlBYoMZV9NlwKrAGCJDGxTKo2'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => print('eat a dic'),
        child: const Icon(
          Icons.add
        ),
      ),
    ),
  );
}
