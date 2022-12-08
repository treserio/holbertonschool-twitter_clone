import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/all.dart';
import '../screens/profile_screen.dart';
import '../models/user_data.dart';

class PostWidget extends StatelessWidget {
  final String avatar;
  final String name;
  final String username;
  final int time;
  final String post;
  final List<Widget> hashtags;
  final int resquaks;
  final int replies;
  final int hearts;
  final String userKey;


  const PostWidget({
    super.key,
    this.avatar = 'https://avatars.githubusercontent.com/u/30158551?v=4',
    this.name = 'Name',
    this.username = 'Username',
    this.time = 2,
    this.post = 'Post',
    this.hashtags = const [
      Text('#FirstHash', style: TextStyle(color: Colors.deepOrange)),
      Text('#SecontHash', style: TextStyle(color: Colors.deepOrange)),
    ],
    this.resquaks = 99,
    this.replies = 9,
    this.hearts = 999,
    required this.userKey,
  });

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Consumer<AuthState>(
        builder: (_, state, __) => GestureDetector(
          onTap: () async {
            UserData poster = await state.getUserDataById(userKey);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                ProfileScreen(
                  profileUserData: poster,
                ),
              ),
            );
          },
          child: CircleAvatar(
            foregroundImage: NetworkImage(avatar),
          ),
        ),
      ),

      title: Wrap(
        spacing: 10,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            '@$username · $time m',
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
          Text(
            post,
            style: const TextStyle(
              color: Colors.black,
            )
          ),
          Wrap(
            spacing: 10,
            children: hashtags,
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
