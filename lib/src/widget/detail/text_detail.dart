import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TextDetail extends StatelessWidget {
  final String title;
  final DateTime? date;
  final String time;
  final String content;

  const TextDetail({Key? key, required this.title, this.date, required this.time, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateString = '';
    if (date != null) {
      dateString = DateFormat('dd/MM/yyyy').format(date!);
    }
    return ListView(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 40),
        Text(content),
        SizedBox(height: 15),
        Text(time + ' - ' + dateString),
        SizedBox(height: 40)
      ],
    );
  }
}
