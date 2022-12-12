import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_state.dart';
import '../widgets/all.dart';
import '../models/user_data.dart';

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
  late CollectionReference userDataRef = Provider.of<AuthState>(context).userDataRef;

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

  Future<List<UsersSearchResult>> fetchResults(search, activeUser, setState) async {
    List<UsersSearchResult> results = [];
    if (search == '') {
      var queryRes = await userDataRef.get();
      for (var doc in queryRes.docs) {
        dynamic user = doc.data();
        user.key != activeUser.key ?
          results.add(
            UsersSearchResult(
              user: user,
              activeUser: activeUser,
              setState: setState,
            )
          ) : null;
      }
    } else {
      var queryRes = await userDataRef.get();
      for (var doc in queryRes.docs) {
        dynamic user = doc.data();
        if (
          user.key != activeUser.key &&
          (user.name.contains(search) || user.userName.contains(search))
        ) {
          results.add(
            UsersSearchResult(
              user: user,
              activeUser: activeUser,
              setState: setState,
            )
          );
        }
      }
    }
    return results;
  }

  @override
  Widget build(BuildContext context) => Consumer<AuthState>(
    builder: (_, state, __) => Scaffold(
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
                    foregroundImage: NetworkImage(state.activeUserData!.avatar),
                  ),
                )
              ),
              Expanded(
                flex: 9,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    focusColor: Colors.blue,
                    hoverColor: Colors.green,
                    hintText: 'Search',
                  ),
                  textAlignVertical: const TextAlignVertical(y: 0),
                  onEditingComplete: () => setState(() {}),
                )
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
        future: fetchResults(
          _searchController.text,
          state.activeUserData,
          setState,
        ),
        builder: (context, snapshot) => ListView.builder(
          itemBuilder: (context, index) => snapshot.data![index],
          itemCount: snapshot.hasData ? snapshot.data!.length : 0,
        ),
      ),
      bottomNavigationBar: const BottomMenuBar(),
    ),
  );
}
