import 'package:flutter/material.dart';
import 'package:frontend_sws/components/Button.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:getwidget/getwidget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../util/ToastUtil.dart';

// Form Login Ente / Comune
class LoginForm extends StatefulWidget {
  final UserService? userService;

  const LoginForm({Key? key, this.userService}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _isLoading = false;
  var _loginError = false;

  Future<bool> login(String username, String password) async {
    setState(() => {_isLoading = true, _loginError = false});
    var a = await widget.userService?.login(username, password);
    setState(() => {_isLoading = false, _loginError = a == null});
    if (a != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: !_isLoading
                ? SizedBox(
                    height: 400,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Accedi',
                              style: TextStyle(
                                  color: appTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Inserisci le credenziali fornite\ndal Comune di Salerno:',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: TextField(
                            obscureText: true,
                            controller: passwordController,
                            cursorColor: appTheme.primaryColor,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25),
                          height: 60,
                          width: 170,
                          child: Button(
                            onPressed: () async {
                              bool res = await login(emailController.text,
                                  passwordController.text);
                              if (mounted) {
                                if (res) Navigator.pop(context);
                              }
                              if (_loginError && mounted) {
                                ToastUtil.error(
                                  'Credenziali non valide :(',
                                  context
                                );

                              }
                            },
                            textButton: "Accedi",
                            status: true,
                            icon: Icons.login_outlined,
                          ),
                        ),
                      ],
                    ))
                : Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                      size: 80,
                      color: appTheme.primaryColor,
                    )))));
  }
}
