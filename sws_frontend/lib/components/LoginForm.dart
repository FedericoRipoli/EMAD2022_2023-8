import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend_sws/main.dart';

// Form Login Ente / Comune
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
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
                        labelText: 'E-mail',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: Text(
                      'Ho dimenticato la mia Password',
                      style: TextStyle(color: appTheme.primaryColor),
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
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        child: const Text('Accedi'),
                        onPressed: () {
                          if (kDebugMode) {
                            print(emailController.text);
                            print(passwordController.text);
                          }
                        },
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Non possiedi le credenziali?'),
                      TextButton(
                        child: Text(
                          'Richiedi il tuo account',
                          style: TextStyle(
                              fontSize: 14, color: appTheme.primaryColor),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}
