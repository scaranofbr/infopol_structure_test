import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infopol_structure_test/src/model/login_response.dart';
import 'package:infopol_structure_test/src/screen/menu_list.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Future<http.Response> futureResponse;

  Future<http.Response> _login(String account, String password) async {
    final url = Uri.parse('https://infopol.poliziadistato.it/grab/new_panel/');
    Map<String, String> body = {'username': account, 'password': password};
    return await http.post(url, body: body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('InfoPOL Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'dstech',
              enabled: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Account'),
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: 'Polizia2021',
              obscureText: true,
              enabled: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Text('ACCEDI'),
                onPressed: () async {
                  BuildContext? dialogContext;
                  showDialog(
                    context: context,
                    builder: (context) {
                      dialogContext = context;
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  );

                  var response = await _login('dstech', 'Polizia2021');
                  if (dialogContext != null) {
                    Navigator.pop(dialogContext!);
                  }
                  var jsonStr = response.body;
                  // print(response.headers['set-cookie']);
                  if (response.statusCode == 200) {
                    var loginResult = LoginResponse.fromJson(jsonStr);
                    // print(jsonStr);
                    // print(loginResult.token);
                    if (loginResult.code == '000') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuList(
                                  loginResult.token, response.headers['set-cookie'] ?? "", loginResult.menu)));
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
