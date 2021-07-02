import 'package:flutter/cupertino.dart';
import 'package:infopol_structure_test/src/model/article/text_article.dart';
import 'package:intl/intl.dart';

class TextDetail extends StatelessWidget {
  final TextArticle model;

  const TextDetail({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateString = '';
    if (model.data != null) {
      dateString = DateFormat('dd/MM/yyyy').format(model.data!);
    }
    return ListView(
      children: [
        Text(model.title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 40),
        Text(model.content),
        SizedBox(height: 15),
        Text(model.ora.toString() + ' - ' + dateString),
        SizedBox(height: 40)
      ],
    );
  }
}
