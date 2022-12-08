import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widgets/all.dart';
import '../providers/all.dart';
import '../models/user_data.dart';

class EditProfileScreen extends StatefulWidget {
  final UserData? profileUserData;

  const EditProfileScreen ({
    super.key,
    required this.profileUserData,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _avatarController;
  late TextEditingController _bioController;
  late TextEditingController _coverController;
  late TextEditingController _nameController;
  late TextEditingController _usernameController;

  late Icon saveIcon;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _avatarController = TextEditingController();
    _bioController = TextEditingController();
    _coverController = TextEditingController();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();

    saveIcon = const Icon(
      Icons.save,
      color: Colors.grey,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _avatarController.dispose();
    _bioController.dispose();
    _coverController.dispose();
    _nameController.dispose();
    _usernameController.dispose();

  }

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
            padding: const EdgeInsets.only(right: 20),
            child: MouseRegion(
              onEnter: (_) {
                saveIcon = Icon(
                  Icons.save,
                  color: Colors.blue.shade800,
                );
                setState(() {});
              },
              onExit: (_) {
                saveIcon = const Icon(
                  Icons.save,
                  color: Colors.grey,
                );
                setState(() {});
              },
              child: GestureDetector(
                  onTap: () async {
                    try {
                      if (_nameController.text != '') {
                        state.activeUserData!.name = _nameController.text;
                      }
                      if (_usernameController.text != '') {
                        state.activeUserData!.userName = _usernameController.text;
                      }
                      if (_bioController.text != '') {
                        state.activeUserData!.bio = _bioController.text;
                      }
                      await state.userDataRef.doc(state.activeUserData!.key).set(state.activeUserData);
                      setState(() => {});
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(_).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Account Updated'),
                        ),
                      );
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(_).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Save Failed, please try again'),
                        ),
                      );
                    }
                  },
                  child: saveIcon,
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
                      image: NetworkImage(widget.profileUserData!.coverImgUrl),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Center(
                    child: OutlinedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(60, 60)),
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(8)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
                        overlayColor: MaterialStateProperty.all<Color>(Colors.blue.shade100),
                        shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) =>
                          RoundedRectangleBorder(
                            side: BorderSide(
                              style: BorderStyle.none,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: const Icon(Icons.edit),
                      onPressed: () => showDialog(
                        context: _,
                        builder: (_) => AlertDialog(
                          title: Wrap(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6, right: 8),
                                child: Text('Enter New Cover Url'),
                              ),
                              IconButton(
                                hoverColor: Colors.green,
                                color: Colors.blue.shade800,
                                icon: const Icon(Icons.add_a_photo_outlined),
                                onPressed: () async {
                                  if (_coverController.text != '') {
                                    try {
                                      http.Response res = await http.get(Uri.parse(_coverController.text));
                                      if (res.statusCode == 200 && res.headers['content-type']!.contains('image')) {
                                        state.activeUserData!.coverImgUrl =
                                          _coverController.text;
                                        setState(() {});
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }
                                },
                              ),
                            ]
                          ),
                          content: EntryField(
                            hint: 'Cover Url',
                            controller: _coverController,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150, left: 25),
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.profileUserData!.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(55),
                      border: Border.all(
                        width: 5,
                        color: Colors.white
                      ),
                    ),
                    child: Center(
                      child: OutlinedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(Size(60, 60)),
                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(8)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.5)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
                          overlayColor: MaterialStateProperty.all<Color>(Colors.blue.shade100),
                          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) =>
                            RoundedRectangleBorder(
                              side: BorderSide(
                                style: BorderStyle.none,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        child: Icon(Icons.edit),
                        onPressed: () => showDialog(
                          context: _,
                          builder: (_) => AlertDialog(
                            title: Wrap(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 6, right: 8),
                                  child: Text('Enter New Avatar Url'),
                                ),
                                IconButton(
                                  hoverColor: Colors.green,
                                  color: Colors.blue.shade800,
                                  icon: const Icon(Icons.add_a_photo_outlined),
                                  onPressed: () async {
                                    if (_avatarController.text != '') {
                                      try {
                                        http.Response res = await http.get(Uri.parse(_avatarController.text));
                                        if (res.statusCode == 200 && res.headers['content-type']!.contains('image')) {
                                          state.activeUserData!.imageUrl =
                                            _avatarController.text;
                                          setState(() {});
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  },
                                ),
                              ]
                            ),
                            content: EntryField(
                              hint: 'Avatar Url',
                              controller: _avatarController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              shrinkWrap: true,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '  Enter New Name',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    focusColor: Colors.blue,
                    hoverColor: Colors.green,
                    hintText: widget.profileUserData!.name,
                  ),
                  textAlignVertical: const TextAlignVertical(y: 0),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '  Enter New Username',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    focusColor: Colors.blue,
                    hoverColor: Colors.green,
                    hintText: widget.profileUserData!.userName,
                  ),
                  textAlignVertical: const TextAlignVertical(y: 0),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '  Enter New Bio',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextField(
                  controller: _bioController,
                  maxLength: 500,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: widget.profileUserData!.bio,
                  ),
                )
              ],
            )
          ]
        ),
      ),
    ),
  );
}
