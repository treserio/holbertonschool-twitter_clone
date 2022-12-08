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
  late UserData? activeUserData = Provider.of<AuthState>(context).activeUserData;

  late Icon heartIcon = widget.post.likeList.contains(activeUserData?.key) ?
    heartIcon = Icon(
      Icons.favorite,
      color: Colors.red.shade800,
    ) : const Icon(Icons.favorite);

  DateFormat timeSince = DateFormat('dd days');

  @override
  Widget build(BuildContext context) {

    List<Widget> hashtagWidgets = [];
    for (var tag in widget.post.hashtags) {
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
                  foregroundImage: NetworkImage(snapshot.data!.avatar),
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
                      DateTime.now().difference(
                        widget.post.createdAt.toDate()
                      ).inDays
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
                    padding: const EdgeInsets.only(top: 2, bottom: 8),
                    child: Text(
                      widget.post.postText,
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
                        Text('${widget.post.resquaks}'),
                        const Icon(Icons.replay),
                        Text('${widget.post.replies}'),
                        MouseRegion(
                          onEnter: (_) {
                            heartIcon = Icon(
                              Icons.favorite,
                              color: Colors.red.shade300,
                            );
                            setState(() {});
                          },
                          onExit: (_) async {
                            heartIcon = widget.post.likeList
                              .contains(activeUserData?.key) ?
                                heartIcon = Icon(
                                  Icons.favorite,
                                  color: Colors.red.shade800,
                                )
                              : const Icon(Icons.favorite);
                            setState(() {});
                          },
                          child: GestureDetector(
                            onTap: () {
                              if (widget.post.likeList.contains(activeUserData?.key)) {
                                widget.post.likeList.remove(activeUserData?.key);
                                widget.post.hearts -= 1;
                                heartIcon = const Icon(Icons.favorite);
                              } else {
                                widget.post.likeList.add(activeUserData?.key);
                                widget.post.hearts += 1;
                                heartIcon = Icon(
                                  Icons.favorite,
                                  color: Colors.red.shade800,
                                );
                              }
                              setState(() {});
                              postRef.doc(widget.post.key).set(widget.post);
                            },
                            child: heartIcon,
                          )
                        ),
                        Text('${widget.post.hearts}'),
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
