import 'dart:convert';

import 'package:infopol_structure_test/src/model/article/article.dart';

class JournalArticle extends Article {
  JournalArticle({
    required String id,
    required String title,
    required String link,
    required String prev,
    required String content,
    required DateTime? data,
    required String ora,
    required String table,
    required int file,
    required this.testata,
    required this.mime,
    required this.ext,
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

  final String testata;
  final String mime;
  final String ext;

  factory JournalArticle.fromJson(String str) =>
      JournalArticle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JournalArticle.fromMap(Map<String, dynamic> json) => JournalArticle(
        id: json["id"],
        title: json["title"],
        testata: json["testata"],
        link: json["link"],
        content: json["content"],
        mime: json["mime"],
        ext: json["ext"],
        prev: json["prev"],
        data: DateTime.tryParse(json["data"]),
        ora: json["ora"],
        table: json["table"],
        file: json["file"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "testata": testata,
        "link": link,
        "content": content,
        "mime": mime,
        "ext": ext,
        "prev": prev,
        "data":
            "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}",
        "ora": ora,
        "table": table,
        "file": file,
      };
}
