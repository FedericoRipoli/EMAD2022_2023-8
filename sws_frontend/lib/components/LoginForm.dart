import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
                ? Container(
                    height: 480,
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Accedi a Salerno Amica',
                              style: TextStyle(
                                  color: appTheme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Inserisci le credenziali fornite\ndal Comune di Salerno:',
                              style: TextStyle(
                                fontSize: 16,
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: appTheme.primaryColor,
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              child: const Text('Accedi'),
                              onPressed: () async {
                                bool res = await login(emailController.text,
                                    passwordController.text);
                                if(mounted){
                                  if (res) Navigator.pop(context);
                                }
                              },
                            )),
                        _loginError
                            ? Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Credenziali non valide',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red),
                                ))
                            : Container()
                      ],
                    ))
                : Container(
                    height: 480,
                    alignment: Alignment.center,
                    child: Center(
                        child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: appTheme.primaryColor,
                      rightDotColor: appTheme.secondaryHeaderColor,
                      size: 80,
                    )))));
  }
}
