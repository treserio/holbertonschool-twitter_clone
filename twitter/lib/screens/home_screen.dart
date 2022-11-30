import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
    ),
    drawer: const SideBarMenu(),
    bottomNavigationBar: const BottomMenuBar(),
    body: const PostWidget(),
  );
}
