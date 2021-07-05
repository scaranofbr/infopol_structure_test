import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infopol_structure_test/src/model/article/article.dart';
import 'package:infopol_structure_test/src/model/article/journal_article.dart';
import 'package:infopol_structure_test/src/model/article/newsstand_article.dart';
import 'package:infopol_structure_test/src/model/article/text_article.dart';
import 'package:infopol_structure_test/src/model/article/tv_article.dart';
import 'package:infopol_structure_test/src/model/article/video_article.dart';
import 'package:infopol_structure_test/src/model/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:infopol_structure_test/src/screen/detail.dart';
import 'package:infopol_structure_test/src/widget/detail/link_detail.dart';

class Tabs extends StatefulWidget {
  final String title;
  final String token;
  final String cookie;
  final List<Item> items;

  const Tabs(
      {required this.title,
      required this.cookie,
      required this.token,
      required this.items,
      Key? key})
      : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.items.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            isScrollable: true,
            tabs: widget.items.map((item) => Text(item.key)).toList(),
          ),
        ),
        body: TabBarView(
          children: widget.items.map((item) {
            if (item.type == 'url') {
              return LinkDetail(title: '', time: '', link: item.val);
            }
            return FutureBuilder<List<Article>>(
                future: _getArticles(item.val),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                      if (data != null) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(data[index].title),
                                subtitle: Text(data[index].prev),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Detail(article: data[index]);
                                  }));
                                },
                              );
                            },
                            separatorBuilder: (context, _) {
                              return Divider();
                            },
                            itemCount: data.length);
                      } else {
                        return Center(
                            child:
                                Text('Error: ${snapshot.error?.toString()}'));
                      }
                  }
                });
          }).toList(),
        ),
      ),
    );
  }

  Future<List<Article>> _getArticles(String parameterValue) async {
    var url = Uri.parse(
        'https://infopol.poliziadistato.it/grab/new_panel/ax_get_news/');
    // print(parameterValue);
    // print(widget.token);
    Map<String, String> headers = {
      'token': widget.token,
      'Cookie': widget.cookie
    };
    var response =
        await http.post(url, body: {'ch': parameterValue}, headers: headers);
    if (response.statusCode != 200) throw Exception(response.statusCode);
    // print(response.body);
    List maps = json.decode(response.body);
    List<Article> articles = maps.map((article) {
      if (article['ext'] == 'pdf') {
        if (article['pb'] != null) {
          return NewsstandArticle.fromMap(article);
        } else {
          return JournalArticle.fromMap(article);
        }
      } else if (article['video5'] != null) {
        return VideoArticle.fromMap(article);
      } else if (article['winmobile'] != null) {
        return TvArticle.fromMap(article);
      } else if (article['content_ai'] != null) {
        return TextArticle.fromMap(article);
      } else {
        return Article.fromMap(article);
      }
    }).toList();
    return articles;
  }
}
