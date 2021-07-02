import 'dart:convert';
import 'package:infopol_structure_test/src/model/article/article.dart';

class TvArticle extends Article {
  TvArticle({
    required String id,
    required String title,
    required String link,
    required String prev,
    required String content,
    required DateTime? data,
    required String ora,
    required String table,
    required int file,
    required this.winmobile,
    required this.img,
  }) : super(
            id: id,
            title: title,
            link: link,
            prev: prev,
            content: content,
            data: data,
            ora: ora,
            table: table,
            file: file);

  final String winmobile;
  final String img;

  factory TvArticle.fromJson(String str) => TvArticle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TvArticle.fromMap(Map<String, dynamic> json) => TvArticle(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        content: json["content"],
        winmobile: json["winmobile"],
        prev: json["prev"],
        img: json["img"],
        data: DateTime.tryParse(json["data"]),
        ora: json["ora"],
        table: json["table"],
        file: json["file"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "content": content,
        "winmobile": winmobile,
        "prev": prev,
        "img": img,
        "data": data,
        "ora": ora,
        "table": table,
        "file": file,
      };
}
