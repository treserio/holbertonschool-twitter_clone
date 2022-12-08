import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/all.dart';
import '../screens/profile_screen.dart';
import '../models/all.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late String postText;
  late DateTime createdAt;
  late List<dynamic> hashtags;

  late int resquaks;
  late int replies;
  late int hearts;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    postText = widget.post.postText;
    createdAt = widget.post.createdAt.toDate();
    hashtags = widget.post.hashtags;
    resquaks = widget.post.resquaks;
    replies = widget.post.replies;
    hearts = widget.post.hearts;
  }

  DateFormat timeSince = DateFormat('dd days');

  @override
  Widget build(BuildContext context) {

    List<Widget> hashtagWidgets = [];
    for (var tag in hashtags) {
      hashtagWidgets.add(
        Text('#$tag', style: const TextStyle(color: Colors.deepOrange)),
      );
    }

    return FutureBuilder<UserData?>(
      future: Provider.of<AuthState>(context).getUserDataById(widget.post.userKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                      ProfileScreen(
                        profileUserData: snapshot.data,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  foregroundImage: NetworkImage(snapshot.data!.imageUrl),
                ),
              ),
              title: Wrap(
                spacing: 10,
                children: [
                  Text(
                    snapshot.data!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '@${snapshot.data!.userName} · ${
                      DateTime.now().difference(createdAt).inDays
                    } days ago',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.deepOrange,
                    ),
                  ),
                ]
              ),
              trailing: GestureDetector(
                onTap: () => print('downArrow'),
                child: const Icon(
                  Icons.arrow_drop_down,
                )
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      postText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    children: hashtagWidgets,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ButtonBar(
                      // alignment: MainAxisAlignment.end,
                      buttonPadding: const EdgeInsets.only(left: 35),
                      children: [
                        const Icon(Icons.chat_bubble_rounded),
                        Text('$resquaks'),
                        const Icon(Icons.replay),
                        Text('$replies'),
                        const Icon(Icons.favorite),
                        Text('$hearts'),
                        const Icon(Icons.share),
                      ]
                    ),
                  ),
                ],
              )
            )
          );
        }
        return const Text('');
      }
    );
  }
}
