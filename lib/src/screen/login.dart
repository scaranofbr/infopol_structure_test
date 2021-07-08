import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:infopol_structure_test/src/model/login_response.dart';
import 'package:infopol_structure_test/src/screen/menu_list.dart';
import 'package:infopol_structure_test/src/screen/onboarding.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


enum ButtonStatus { empty, full, loading }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FlutterSecureStorage storage = FlutterSecureStorage();
  LocalAuthentication auth = LocalAuthentication();
  late bool _canCheckBiometrics;
  late List<BiometricType> _availableBiomterics;
  late bool _authenticated;

  late Future<http.Response> futureResponse;

  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late StreamController<String> _accountStream;
  late StreamController<String> _passwordStream;
  late StreamController<bool> _isLoadingStream;

  @override
  void initState() {
    _accountStream = StreamController.broadcast();
    _passwordStream = StreamController.broadcast();
    _isLoadingStream = StreamController.broadcast();
    _authenticateIfNeeded();   

    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _authenticateIfNeeded() async {
    String? savedAccount = await storage.read(key: 'account');
    String? savedPassword = await storage.read(key: 'password');
    if (savedAccount != null && savedPassword != null) {
      await _checkBiometrics();
      if (!_canCheckBiometrics) return;
      await _getAvailableBiometrics();
      await _authenticate();
      if (!_authenticated) return;
      var response =
          await _login(savedAccount, savedPassword);
      var jsonStr = response.body;
      if (response.statusCode != 200) return;
      var loginResult = LoginResponse.fromJson(jsonStr);
      if (loginResult.code != '000') return;
      _navigateToOnboarding(loginResult.token, response.headers['set-cookie'] ?? "",
          loginResult.menu);
    }
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      if (!mounted) return;
      print(canCheckBiometrics);
      setState(() {
        _canCheckBiometrics = canCheckBiometrics;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiomterics;
    try {
      availableBiomterics = await auth.getAvailableBiometrics();
      if (!mounted) return;
      print(availableBiomterics);
      setState(() {
        _availableBiomterics = availableBiomterics;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Autenticati',
          biometricOnly: true,
          useErrorDialogs: true);
      if (!mounted) return;
      print(authenticated);
      setState(() {
        _authenticated = authenticated;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<http.Response> _login(String account, String password) async {
    final url = Uri.parse('https://infopol.poliziadistato.it/grab/new_panel/');
    Map<String, String> body = {'username': account, 'password': password};
    return await http.post(url, body: body);
  }

  ButtonStatus _statiBottone(String? a, String? b, bool? isLoading) {
    if (isLoading != null && isLoading) return ButtonStatus.loading;
    if (a != null && a.isNotEmpty && b != null && b.isNotEmpty)
      return ButtonStatus.full;
    return ButtonStatus.empty;
  }

  _navigateToOnboarding(String token, String cookie, List<Menu> menu) {
    
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => OnBoarding(token, cookie, menu)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                    controller: _accountController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Account'),
                    onChanged: _accountStream.add,
                  ),
            SizedBox(height: 20),
            TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
                    onChanged: _passwordStream.add,
                  ),
            Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder<ButtonStatus>(
                  initialData: ButtonStatus.empty,
                  stream: CombineLatestStream.combine3(
                      _accountStream.stream,
                      _passwordStream.stream,
                      _isLoadingStream.stream.startWith(false),
                      (String? a, String? b, bool? c) =>
                          _statiBottone(a, b, c)),
                  builder: (context, snapshot) {
                    if (snapshot.data == ButtonStatus.loading)
                      return CircularProgressIndicator();
                    return ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.loginButtonText),
                      onPressed: snapshot.data == ButtonStatus.empty
                          ? null
                          : () async {
                              _isLoadingStream.add(true);
                              var response = await _login(
                                  _accountController.text,
                                  _passwordController.text);
                              _isLoadingStream.add(false);
                              var jsonStr = response.body;
                              if (response.statusCode == 200) {
                                var loginResult =
                                    LoginResponse.fromJson(jsonStr);
                                if (loginResult.code == '000') {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Salvare i dati per il l'autenticazione biometrica?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () async {
                                                  storage.write(
                                                      key: 'account',
                                                      value: _accountController
                                                          .text);
                                                  storage.write(
                                                      key: 'password',
                                                      value: _passwordController
                                                          .text);
                                                  Navigator.pop(context);
                                                  _navigateToOnboarding(
                                                      loginResult.token,
                                                      response.headers[
                                                              'set-cookie'] ??
                                                          "",
                                                      loginResult.menu);
                                                },
                                                child: Text('OK')),
                                            TextButton(
                                                onPressed: () {
                                                  storage.delete(
                                                      key: 'account');
                                                  storage.delete(
                                                      key: 'password');
                                                  Navigator.pop(context);
                                                  _navigateToOnboarding(
                                                      loginResult.token,
                                                      response.headers[
                                                              'set-cookie'] ??
                                                          "",
                                                      loginResult.menu);
                                                },
                                                child: Text('Annulla'))
                                          ],
                                        );
                                      });
                                }
                              }
                            },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
