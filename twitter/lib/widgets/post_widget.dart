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
  // hard returns will still show up, may need to limit on those as well
  late int lastSpace = widget.post.postText.substring(0, 198).lastIndexOf(' ');
  late String displayText = widget.post.postText.length > 200 ?
    '${widget.post.postText.substring(0, lastSpace)}...' :
    widget.post.postText;


  late Icon heartIcon = widget.post.likeList.contains(activeUserData?.key) ?
    Icon(
      Icons.favorite,
      color: Colors.red.shade800,
    ) : const Icon(Icons.favorite);
  late Icon repliesIcon = widget.post.repliesList.contains(activeUserData?.key) ?
    Icon(
      Icons.replay,
      color: Colors.purple.shade800,
    ) : const Icon(Icons.replay);
  late Icon resquaksIcon = widget.post.resquaksList.contains(activeUserData?.key) ?
    Icon(
      Icons.chat_bubble_rounded,
      color: Colors.green.shade800,
    ) : const Icon(Icons.chat_bubble_rounded);


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
          return ExpansionTile(
            textColor: Colors.black,
            iconColor: Colors.grey.shade700,
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
            subtitle: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 8),
                  child: Text(
                    displayText,
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
                      MouseRegion(
                        onEnter: (_) {
                          resquaksIcon = Icon(
                            Icons.chat_bubble_rounded,
                            color: Colors.green.shade300,
                          );
                          setState(() {});
                        },
                        onExit: (_) async {
                          resquaksIcon = widget.post.resquaksList
                            .contains(activeUserData?.key) ?
                              resquaksIcon = Icon(
                                Icons.chat_bubble_rounded,
                                color: Colors.green.shade800,
                              )
                            : const Icon(Icons.chat_bubble_rounded);
                          setState(() {});
                        },
                        child: GestureDetector(
                          onTap: () {
                            if (widget.post.resquaksList.contains(activeUserData?.key)) {
                              widget.post.resquaksList.remove(activeUserData?.key);
                              widget.post.resquaks -= 1;
                              resquaksIcon = const Icon(Icons.chat_bubble_rounded);
                            } else {
                              widget.post.resquaksList.add(activeUserData?.key);
                              widget.post.resquaks += 1;
                              resquaksIcon = Icon(
                                Icons.chat_bubble_rounded,
                                color: Colors.green.shade800,
                              );
                            }
                            setState(() {});
                            postRef.doc(widget.post.key).set(widget.post);
                          },
                          child: resquaksIcon,
                        )
                      ),
                      Text('${widget.post.resquaks}'),
                      MouseRegion(
                        onEnter: (_) {
                          repliesIcon = Icon(
                            Icons.replay,
                            color: Colors.purple.shade300,
                          );
                          setState(() {});
                        },
                        onExit: (_) async {
                          repliesIcon = widget.post.repliesList
                            .contains(activeUserData?.key) ?
                              repliesIcon = Icon(
                                Icons.replay,
                                color: Colors.purple.shade800,
                              )
                            : const Icon(Icons.replay);
                          setState(() {});
                        },
                        child: GestureDetector(
                          onTap: () {
                            if (widget.post.repliesList.contains(activeUserData?.key)) {
                              widget.post.repliesList.remove(activeUserData?.key);
                              widget.post.replies -= 1;
                              repliesIcon = const Icon(Icons.replay);
                            } else {
                              widget.post.repliesList.add(activeUserData?.key);
                              widget.post.replies += 1;
                              repliesIcon = Icon(
                                Icons.replay,
                                color: Colors.purple.shade800,
                              );
                            }
                            setState(() {});
                            postRef.doc(widget.post.key).set(widget.post);
                          },
                          child: repliesIcon,
                        )
                      ),
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
            ),
            onExpansionChanged: (val) {
              val && widget.post.postText.length > 200 ?
              displayText = widget.post.postText
              : widget.post.postText.length > 200 ?
              displayText = '${widget.post.postText.substring(0, lastSpace)}...'
              : null;
              setState(() => {});
            }
            // children: [
            //   widget.post.postText.length > 200 ?
            //   Text(
            //     widget.post.postText.substring(201),
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontSize: 16,
            //     ),
            //   ) : const Text(''),
            // ],
          );
        }
        //   Card(
        //     child: ListTile(


        //       trailing: GestureDetector(
        //         onTap: () => print('downArrow'),
        //         child: const Icon(
        //           Icons.arrow_drop_down,
        //         )
        //       ),

        //     )
        //   );
        // }
        return const Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}
