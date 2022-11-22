import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<List<Character>> fetchBbCharacters() async {
    dynamic res = await http.get(Uri.parse('https://breakingbadapi.com/api/characters'));
    dynamic json = jsonDecode(res.body);
    List<Character> output = [];
    for (var char in json) {
      output.add(Character.fromJson(char));
    }
    return output;
  }

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
            print(snapshot.data?[0].imgUrl);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => Card(
                color: Colors.amber,
                child: Center(child: Text('${snapshot.data?[index].name} ${snapshot.data?[index].imgUrl} ${snapshot.data?[index].id}')),
              ),
            );
          }
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => Card(
                color: Colors.amber,
                child: Center(child: Text('$index')),
              ),
            );
        },
      ),
    );
  }
}
