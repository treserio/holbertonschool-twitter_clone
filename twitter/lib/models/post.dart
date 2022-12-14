import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String key;
  final String userKey;
  final String postText;
  final Timestamp createdAt;
  final List<dynamic> hashtags;
  int resquaks;
  int replies;
  int hearts;
  List<dynamic> likeList;
  List<dynamic> repliesList;
  List<dynamic> resquaksList;

  Post({
    required this.userKey,
    this.key = 'missing',
    this.postText = 'postText',
    Timestamp? createdAt,
    this.hashtags = const [],
    this.resquaks = 0,
    this.replies = 0,
    this.hearts = 0,
    this.likeList = const [],
    this.repliesList = const [],
    this.resquaksList = const [],
  }) : createdAt = createdAt ?? Timestamp.now();

  static Post fromJson(Map<String, dynamic> json) => Post(
    key: json['key'],
    userKey: json['userKey'],
    postText: json['postText'],
    createdAt: json['createdAt'],
    hashtags: json['hashtags'],
    resquaks: json['resquaks'],
    replies: json['replies'],
    hearts: json['hearts'],
    likeList: json['likeList'],
    repliesList: json['repliesList'],
    resquaksList: json['resquaksList'],
  );

  Map<String, Object> toJson() => {
    'key': key,
    'userKey': userKey,
    'postText': postText,
    'createdAt': createdAt,
    'hashtags': hashtags,
    'resquaks': resquaks,
    'replies': replies,
    'hearts': hearts,
    'likeList': likeList,
    'repliesList': repliesList,
    'resquaksList': resquaksList,
  };
}

CollectionReference<Post?> postRef = FirebaseFirestore
  .instance
  .collection('posts')
  .withConverter<Post?>(
    fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
    toFirestore: (post, _) => post!.toJson(),
  );
