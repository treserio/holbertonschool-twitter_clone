import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String key;
  final Timestamp creationTime;
  Timestamp lastSignInTime;
  String email;
  String name;
  String userName;
  String displayName;
  String imageUrl;
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
    this.imageUrl = 'https://static.wikia.nocookie.net/disneythehunchbackofnotredame/images/7/79/Scuttle.jpg/revision/latest/scale-to-width-down/294?cb=20171108011616',
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
    imageUrl: json['imageUrl'],
    followers: json['followers'],
    following: json['following'],
    followersList: json['followersList'],
    followingList: json['followingList'],
  );

  Map<String, Object> toJson() => {
    'key': key,
    'creationTime': creationTime,
    'lastSignInTime': lastSignInTime,
    'email': email,
    'name': name,
    'userName': userName,
    'displayName': displayName,
    'imageUrl': imageUrl,
    'followers': followers,
    'following': following,
    'followersList': followersList,
    'followingList': followingList,
  };
}
