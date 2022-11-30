import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../screens/all.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({
    super.key,
  });

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  @override
  Widget build(BuildContext context) {
    int index = Provider.of<AppState>(context, listen: false).pageIndex;

    Color homeColor = index == 0 ?
      Colors.blue.shade800 : Colors.grey;
    Color searchColor = index == 1 ?
      Colors.blue.shade800 : Colors.grey;
    Color notifColor = index == 2 ?
      Colors.blue.shade800 : Colors.grey;
    Color chatsColor = index == 3 ?
      Colors.blue.shade800 : Colors.grey;

    return Consumer<AppState>(
      builder: (context, state, child) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                state.setpageIndex = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: Icon(
                Icons.home,
                color: homeColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                state.setpageIndex = 1;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Icon(
                Icons.search,
                color: searchColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                state.setpageIndex = 2;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                );
              },
              child: Icon(
                Icons.notifications,
                color: notifColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                state.setpageIndex = 3;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatsScreen()),
                );
              },
              child: Icon(
                Icons.mail,
                color: chatsColor,
              ),
            ),
          ],
        ),
      )
    );
  }
}
