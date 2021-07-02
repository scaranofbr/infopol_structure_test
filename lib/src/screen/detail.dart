import 'package:flutter/material.dart';
import 'package:infopol_structure_test/src/model/article/article.dart';
import 'package:infopol_structure_test/src/model/article/journal_article.dart';
import 'package:infopol_structure_test/src/model/article/newsstand_article.dart';
import 'package:infopol_structure_test/src/model/article/text_article.dart';
import 'package:infopol_structure_test/src/model/article/tv_article.dart';
import 'package:infopol_structure_test/src/model/article/video_article.dart';
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
        return TextDetail(model: article as TextArticle);
      case VideoArticle:
        return VideoDetail(model: article as VideoArticle);
      case TvArticle:
        print('tv');
        break;
      case JournalArticle:
        print('journal');
        break;
      case NewsstandArticle:
        print('news');
        break;
    }
    return Container();
  }
}
