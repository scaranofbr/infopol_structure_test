import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkDetail extends StatelessWidget {
  final String title;
  final DateTime? date;
  final String time;
  final String link;

  const LinkDetail(
      {Key? key,
      required this.title,
      this.date,
      required this.time,
      required this.link})
      : super(key: key);

  void _launchURL() async => await canLaunch(link)
      ? await launch(link)
      : throw 'Could not launch $link';

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
        ElevatedButton(onPressed: _launchURL, child: Text('PDF LINK')),
        SizedBox(height: 15),
        Text(time + ' - ' + dateString),
        SizedBox(height: 40)
      ],
    );
  }
}
