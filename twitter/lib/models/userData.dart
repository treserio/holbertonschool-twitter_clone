class UserData {
  String key;
  String email;
  String name;
  String userName;
  String displayName;
  String imageUrl;
  int followers;
  int following;
  List<dynamic> followersList;
  List<dynamic> followingList;

  UserData({
    this.key = 'key',
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

  static UserData fromJson(Map<String, dynamic> json) => UserData(
    key: json['key'],
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
