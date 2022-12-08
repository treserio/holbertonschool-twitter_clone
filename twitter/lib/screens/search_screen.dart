import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_state.dart';
import '../widgets/all.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late String avatar = Provider.of<AuthState>(context).activeUserData!.avatar;

  var searchIcon = const Icon(
    Icons.settings,
    color: Colors.grey,
  );

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  Future<List<UsersSearchResult>> fetchResults(search) async => const [
    UsersSearchResult(),
    UsersSearchResult(),
    UsersSearchResult(),
  ];

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
            Expanded(
              flex: 9,
              child: EntryField(
                hint: 'Search',
                controller: _searchController,
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
    body: FutureBuilder(
      future: fetchResults('stuff'),
      builder: (context, snapshot) => ListView.builder(
        itemBuilder: (context, index) => snapshot.data![index],
        itemCount: snapshot.hasData ? snapshot.data!.length : 0,
      ),
    ),
    bottomNavigationBar: const BottomMenuBar(),
  );
}
