import 'package:flutter/material.dart';
import 'package:infopol_structure_test/src/model/article/article.dart';
import 'package:infopol_structure_test/src/model/article/journal_article.dart';
import 'package:infopol_structure_test/src/model/article/newsstand_article.dart';
import 'package:infopol_structure_test/src/model/article/text_article.dart';
import 'package:infopol_structure_test/src/model/article/tv_article.dart';
import 'package:infopol_structure_test/src/model/article/video_article.dart';
import 'package:infopol_structure_test/src/widget/detail/link_detail.dart';
import 'package:infopol_structure_test/src/widget/detail/text_detail.dart';
import 'package:infopol_structure_test/src/widget/detail/video_detail.dart';

class Detail extends StatelessWidget {
  final Article article;
  const Detail({required this.article, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: _detailForArticle(article),
    );
  }

  Widget _detailForArticle(Article article) {
    switch (article.runtimeType) {
      case TextArticle:
        var model = article as TextArticle;
        return TextDetail(
            title: model.title,
            date: model.data,
            time: model.ora,
            content: model.content);
      case VideoArticle:
        var videoArticle = article as VideoArticle;
        return VideoDetail(link: videoArticle.video5, title: videoArticle.title, date: videoArticle.data, time: videoArticle.ora);
      case TvArticle:
        var tvArticle = article as TvArticle;
        return VideoDetail(link: tvArticle.content, title: tvArticle.title, date: tvArticle.data, time: tvArticle.ora);
      case JournalArticle:
      case NewsstandArticle:
        return LinkDetail(title: article.title, date: article.data, time: article.ora, link: article.link);
    }
    return Container();
  }
}
