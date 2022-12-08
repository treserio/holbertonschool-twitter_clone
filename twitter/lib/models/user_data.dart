import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String key;
  final Timestamp creationTime;
  Timestamp lastSignInTime;
  String email;
  String name;
  String userName;
  String displayName;
  String avatar;
  String bio;
  String coverImgUrl;
  int followers;
  int following;
  List<dynamic> followersList;
  List<dynamic> followingList;

  UserData({
    this.key = 'key',
    Timestamp? creationTime,
    Timestamp? lastSignInTime,
    this.email = 'email',
    this.name = 'name',
    this.userName = 'userName',
    this.displayName = 'displayName',
    this.avatar = 'data:image/jpeg;base64,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',
    this.followers = 0,
    this.following = 0,
    this.followersList = const [''],
    this.followingList = const [''],
    this.bio = 'No bio available',
    this.coverImgUrl = 'https://upload.wikimedia.org/wikipedia/en/8/8d/A_screenshot_from_Star_Wars_Episode_IV_A_New_Hope_depicting_the_Millennium_Falcon.jpg'
  })  : creationTime = creationTime ?? Timestamp.now(),
        lastSignInTime = lastSignInTime ?? Timestamp.now();

  static UserData fromJson(Map<String, dynamic> json) => UserData(
    key: json['key'],
    creationTime: json['creationTime'],
    lastSignInTime: json['lastSignInTime'],
    email: json['email'],
    name: json['name'],
    userName: json['userName'],
    displayName: json['displayName'],
    avatar: json['avatar'],
    followers: json['followers'],
    following: json['following'],
    followersList: json['followersList'],
    followingList: json['followingList'],
    bio: json['bio'],
    coverImgUrl: json['coverImgUrl'],
  );

  Map<String, Object> toJson() => {
    'key': key,
    'creationTime': creationTime,
    'lastSignInTime': lastSignInTime,
    'email': email,
    'name': name,
    'userName': userName,
    'displayName': displayName,
    'avatar': avatar,
    'followers': followers,
    'following': following,
    'followersList': followersList,
    'followingList': followingList,
    'bio': bio,
    'coverImgUrl': coverImgUrl,
  };
}
