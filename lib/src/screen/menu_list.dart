import 'package:flutter/material.dart';
import 'package:infopol_structure_test/src/model/login_response.dart';
import 'package:infopol_structure_test/src/screen/tabs.dart';

class MenuList extends StatelessWidget {
  final String token;
  final String cookie;
  final List<Menu> menus;

  const MenuList(this.token, this.cookie, this.menus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(menus[index].key),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Tabs(
                              title: menus[index].key,
                              token: token,
                              cookie: cookie,
                              items: menus[index].items,
                            )));
              },
            );
          },
          separatorBuilder: (context, _) {
            return Divider();
          },
          itemCount: menus.length),
    );
  }
}
