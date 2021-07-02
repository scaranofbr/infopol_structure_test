import 'dart:convert';
import 'package:infopol_structure_test/src/model/article/article.dart';

class TextArticle extends Article {
  TextArticle({
    required String id,
    required String title,
    required String link,
    required String prev,
    required String content,
    required DateTime? data,
    required String ora,
    required String table,
    required int file,
    required this.idTag,
    required this.imgTag,
    required this.sentiment,
    required this.idRaggruppate,
    required this.contentAi,
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

  final String? idTag;
  final String imgTag;
  final int sentiment;
  final int idRaggruppate;
  final String contentAi;

  factory TextArticle.fromJson(String str) =>
      TextArticle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TextArticle.fromMap(Map<String, dynamic> json) => TextArticle(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        prev: json["prev"],
        content: json["content"],
        data: DateTime.tryParse(json["data"]),
        ora: json["ora"],
        table: json["table"],
        idTag: json["id_tag"],
        imgTag: json["img_tag"],
        file: json["file"],
        sentiment: json["sentiment"],
        idRaggruppate: json["id_raggruppate"],
        contentAi: json["content_ai"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "link": link,
        "prev": prev,
        "content": content,
        "data":
            "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}",
        "ora": ora,
        "table": table,
        "id_tag": idTag,
        "img_tag": imgTag,
        "file": file,
        "sentiment": sentiment,
        "id_raggruppate": idRaggruppate,
        "content_ai": contentAi,
      };
}