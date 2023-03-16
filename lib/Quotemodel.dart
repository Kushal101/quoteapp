import 'dart:convert';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));
String quoteToJson(Quote data) => json.encode(data.toJson());

class Quote {
  String? quotes;
  String? author_name;
  String? tag;
  String? id;

  Quote({
    this.id,
    this.quotes,
    this.author_name,
    this.tag
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    id: json["id"],
    quotes: json["quotes"],
    author_name: json["author_name"],
    tag: json["tag"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quotes": quotes,
    "author_name":author_name,
    "tag":tag
  };
}