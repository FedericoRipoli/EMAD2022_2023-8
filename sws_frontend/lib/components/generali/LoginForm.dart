import 'package:flutter/material.dart';
import 'package:frontend_sws/components/generali/CustomButton.dart';
import 'package:frontend_sws/components/generali/CustomTextField.dart';
import 'package:frontend_sws/main.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:getwidget/getwidget.dart';
import '../../theme/theme.dart';
import '../loading/AllPageLoad.dart';

// Form Login Ente / Comune
class LoginForm extends StatefulWidget {
  final UserService? userService;

  const LoginForm({Key? key, this.userService}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
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
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(6),
          height: 385,
          width: 400,
          child: !_isLoading
              ? Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: AppColors.logoCadmiumOrange,
                              fontFamily: "FredokaOne",
                              fontSize: 24),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Inserisci le credenziali fornite dal Comune',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    CustomTextField(
                        controller: usernameController, label: "Username"),
                    CustomTextField(
                        controller: passwordController, label: "Password"),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 60,
                      width: 170,
                      child: CustomButton(
                        onPressed: () async {
                          bool res = await login(
                              usernameController.text, passwordController.text);
                          if (mounted) {
                            if (res) Navigator.pop(context);
                          }
                          if (_loginError) {
                            GFToast.showToast(
                              'Credenziali non valide',
                              context,
                              toastPosition: GFToastPosition.BOTTOM,
                              textStyle: const TextStyle(
                                  fontSize: 20, color: GFColors.DARK),
                              backgroundColor: Colors.white,
                              trailing: const Icon(
                                Icons.error_outline,
                                color: GFColors.DANGER,
                              ),
                            );
                          }
                        },
                        textButton: "Accedi",
                        icon: Icons.login_outlined,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                  child: const AllPageLoad())),
    );
  }
}
