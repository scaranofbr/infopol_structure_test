import 'dart:convert';

import 'package:infopol_structure_test/src/model/article/article.dart';

class NewsstandArticle extends Article {
  NewsstandArticle({
    required String id,
    required String title,
    required String link,
    required String prev,
    required String content,
    required DateTime? data,
    required String ora,
    required String table,
    required int file,
    required this.mime,
    required this.ext,
    required this.lp,
    required this.img,
    required this.pb,
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

  final String mime;
  final String ext;
  final int lp;
  final String img;
  final String pb;

  factory NewsstandArticle.fromJson(String str) =>
      NewsstandArticle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsstandArticle.fromMap(Map<String, dynamic> json) =>
      NewsstandArticle(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        prev: json["prev"],
        content: json["content"],
        mime: json["mime"],
        ext: json["ext"],
        data: DateTime.tryParse(json["data"]),
        ora: json["ora"],
        table: json["table"],
        lp: json["lp"],
        img: json["img"],
        file: json["file"],
        pb: json["pb"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "prev": prev,
        "content": content,
        "mime": mime,
        "ext": ext,
        "data":
            "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}",
        "ora": ora,
        "table": table,
        "lp": lp,
        "img": img,
        "file": file,
        "pb": pb,
      };
}
