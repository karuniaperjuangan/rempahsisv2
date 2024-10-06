// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
    int id;
    String title;
    String imageUrl;
    String articlePath;

    Article({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.articlePath,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        articlePath: json["article_path"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "image_url": imageUrl,
        "article_path": articlePath,
    };
}
