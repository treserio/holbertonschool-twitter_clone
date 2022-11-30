class User {
  String key;
  String userId;
  String email;
  String name;
  String userName;
  String displayName;
  String imageUrl;
  int followers;
  int following;
  List<String> followersList;
  List<String> followingList;

  User({
    this.key = 'key',
    this.userId = 'userId',
    this.email = 'email',
    this.name = 'name',
    this.userName = 'userName',
    this.displayName = 'displayName',
    this.imageUrl = 'imageUrl',
    this.followers = 0,
    this.following = 0,
    this.followersList = const [''],
    this.followingList = const [''],
  });

  static User fromJson(Map<dynamic, dynamic> json) => User(
    key: json['key'],
    userId: json['userId'],
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

  Map toJson() => {
    'key': key,
    'userId': userId,
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
