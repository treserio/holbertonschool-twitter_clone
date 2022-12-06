import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/all.dart';
import '../screens/all.dart';
import '../models/user_data.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({
    super.key,
  });

  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  late UserData? activeUserData;

  // @override
  // @mustCallSuper
  // void initState() {
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    activeUserData = Provider.of<AuthState>(context).activeUserData;

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              foregroundImage: NetworkImage(activeUserData!.imageUrl),
            ),
            contentPadding: const EdgeInsets.only(left: 20, top: 5),
            onTap: () => print('Avatar'),
            hoverColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
            child: Text(
              activeUserData!.userName,
              style: const TextStyle(
                fontSize: 16
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              children: [
                GestureDetector(
                  child: Text(
                    '${activeUserData!.followers} Followers',
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  onTap: () => print('Followers'),
                ),
                GestureDetector(
                  child: Text(
                    '${activeUserData!.following} Following',
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  onTap: () => print('Following'),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade400),
                bottom: BorderSide(color: Colors.grey.shade400),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.manage_accounts,
                    color: Colors.grey.shade600,
                  ),
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                      ProfileScreen(postUser: activeUserData)
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.list,
                    color: Colors.grey.shade600,
                  ),
                  title: const Text(
                    'Lists',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => print('Lists'),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.bookmark,
                    color: Colors.grey.shade600,
                  ),
                  title: const Text(
                    'Bookmark',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => print('Bookmark'),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 20),
                  leading: Icon(
                    Icons.bolt,
                    color: Colors.grey.shade600,
                  ),
                  title: const Text(
                    'Moments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => print('Moments'),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            title: const Text(
              'Settings and privacy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => print('Settings and privacy'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            title: const Text(
              'Help Center',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => print('Help Center'),
          ),
          Consumer<AppState>(
            builder: (_, state, __) => Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.only(left: 20),
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey.shade600,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // navigate to the SignIn screen, by removing all other routes
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  state.setpageIndex = 0;
                  // ignore: use_build_context_synchronously
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ),
          ),
        ],
      )
    );
  }
}
