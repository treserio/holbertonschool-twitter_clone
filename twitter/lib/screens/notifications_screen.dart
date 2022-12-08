import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_state.dart';
import '../widgets/all.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late String avatar = Provider.of<AuthState>(context).activeUserData!.avatar;

  var searchIcon = const Icon(
    Icons.settings,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
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
                  foregroundImage: NetworkImage(avatar),
                ),
              )
            ),
            const Expanded(
              flex: 9,
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: MouseRegion(
                onEnter: (_) {
                  searchIcon = Icon(
                    Icons.settings,
                    color: Colors.blue.shade800,
                  );
                  setState(() {});
                },
                onExit: (_) {
                  searchIcon = const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  );
                  setState(() {});
                },
                child: GestureDetector(
                  onTap: () => print('searchIcon'),
                  child: searchIcon,
                )
              )
            ),
          ]
        )
      ),
    ),
    body: Center(
      child: ListView(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
        ),
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              'No Notifications Available',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Text(
                'When there are notifications, find them here.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..color = Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ]
      )
    ),
    bottomNavigationBar: const BottomMenuBar(),
  );
}
