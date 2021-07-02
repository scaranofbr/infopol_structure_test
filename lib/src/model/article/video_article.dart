import 'dart:convert';
import 'package:infopol_structure_test/src/model/article/article.dart';

class VideoArticle extends Article {
  VideoArticle({
    required String id,
    required String title,
    required String link,
    required String prev,
    required String content,
    required DateTime? data,
    required String ora,
    required String table,
    required int file,
    required this.video5,
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

  final String video5;

  factory VideoArticle.fromJson(String str) =>
      VideoArticle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoArticle.fromMap(Map<String, dynamic> json) => VideoArticle(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        video5: json["video5"],
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
        "video5": video5,
        "prev": prev,
        "content": content,
        "data":
            "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}",
        "ora": ora,
        "table": table,
        "file": file,
      };
}
