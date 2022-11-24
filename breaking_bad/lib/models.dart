class Character {
  String name;
  String imgUrl;
  int id;

  Character({
    this.name = 'default',
    this.imgUrl = 'url',
    this.id = 0,
  });

  static Character fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      imgUrl: json['img'],
      id: json['char_id'],
    );
  }
}

class Quote {
  String quote;
  String author;
  int id;

  Quote({
    this.quote = 'default',
    this.author = 'url',
    this.id = 0,
  });

  static Quote fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'],
      author: json['author'],
      id: json['quote_id'],
    );
  }
}
