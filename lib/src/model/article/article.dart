// To parse this JSON data, do
//
//     final article = articleFromMap(jsonString);

import 'dart:convert';

class Article {
    Article({
        required this.id,
        required this.title,
        required this.link,
        required this.prev,
        required this.content,
        required this.data,
        required this.ora,
        required this.table,
        required this.file,
    });

    String id;
    String title;
    String link;
    String prev;
    String content;
    DateTime? data;
    String ora;
    String table;
    int file;

    factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Article.fromMap(Map<String, dynamic> json) => Article(
        id: json["id"].toString(),
        title: json["title"],
        link: json["link"],
        prev: json["prev"],
        content: json["content"],
        data: DateTime.tryParse(json["data"]),
        ora: json["ora"],
        table: json["table"],
        file: json["file"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "prev": prev,
        "content": content,
        "data": data != null ? "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}" : "",
        "ora": ora,
        "table": table,
        "file": file,
    };
}
