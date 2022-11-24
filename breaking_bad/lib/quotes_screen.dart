import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'models.dart';

class QuotesScreen extends StatelessWidget {

  final int id;

  const QuotesScreen({
    this.id = 1,
    Key? key,
  }) : super(key: key);

  Future<List<Quote>> fetchQuote(id) async =>
    http.get(Uri.parse('https://breakingbadapi.com/api/characters/$id'))
      .then((charRes) => http.get(Uri.parse('https://breakingbadapi.com/api/quote?author=${
          jsonDecode(charRes.body)[0]['name'].split(' ').join('+')
        }'))
          .then((quoteRes) {
            // print(jsonDecode(quoteRes.body));
            List quotes = jsonDecode(quoteRes.body);
            return quotes.map((quote) => Quote.fromJson(quote)).toList();
          })
          .catchError((err) => throw Exception('Failed to load quotes from API'))
      )
      .catchError((err) => throw Exception('Failed to load characeter $id from API'));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Text('Quotes'),
      )
    ),
    body: FutureBuilder(
      future: fetchQuote(id),
      builder: (context, snapshot) {
        // print('snapshot=${snapshot.data}');
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(snapshot.data![index].quote),
              textColor: Colors.orange,
              tileColor: Colors.blueGrey,
            ),
            itemCount: snapshot.data!.length,
          );
        }
        else if (snapshot.hasError) {
          return Center(
              child: Container(
              width: 250,
              height: 150,
              alignment: const Alignment(0, 0),
              color: Colors.red,
              child: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            )
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    )
  );
}
