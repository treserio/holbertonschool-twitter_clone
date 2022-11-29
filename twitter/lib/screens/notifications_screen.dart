import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/all.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: Colors.black87,
      title: const Center(
        child: Text(
          'Notifications',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          )
        )
      ),
    ),
    bottomNavigationBar: const BottomMenuBar(),
  );
}
