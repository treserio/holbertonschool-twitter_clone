import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UsersSearchResult extends StatelessWidget {
  final String name;
  final String username;
  final String imgUrl;

  const UsersSearchResult({
    super.key,
    this.name = 'Name',
    this.username = 'Username',
    this.imgUrl = 'https://avatars.githubusercontent.com/u/30158551?v=4',
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(
      foregroundImage: NetworkImage(imgUrl),
    ),
    title: Text(
      name,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      '@$username',
    ),
  );
}
