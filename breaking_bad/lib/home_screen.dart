import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Character>> fetchBbCharacters() async =>
    http.get(Uri.parse('https://breakingbadapi.com/api/characters'))
      .then((res) {
        List characters = jsonDecode(res.body);
        return characters.map((char) => Character.fromJson(char)).toList();
      })
      .catchError((err) => throw Exception('Failed to load characters from API'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking Bad Quotes'),
      ),
      body: FutureBuilder(
        future: fetchBbCharacters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 5/3,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => GridTile(
                footer: Container(
                  margin: const EdgeInsets.only(bottom: 25.0, left: 25.0),
                  child: Text(
                    '${snapshot.data?[index].name}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(1),
                      fontSize: 40,
                    ),
                  ),
                ),
                child: Image.network(
                    '${snapshot.data?[index].imgUrl}',
                    fit: BoxFit.fitWidth,
                ),
              ),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Card(
                color: Colors.amber,
                child: Center(child: Text('preload, $index')),
              ),
            );
        },
      ),
    );
  }
}
