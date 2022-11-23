import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Utente.dart';
import 'package:frontend_sws/services/UtenteService.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:frontend_sws/services/dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

void main() {
  test("Utenti", () async {
    await SharedPreferencesUtils.init();
    UtenteService u = UtenteService();
    UserService userService = UserService();
    TokenDto? token = await userService.login("admin", "admin");

    Utente? a = await u.createUtente(
        SignupDto(username: "admin3", password: "admin", idEnte: "1"));
    if (a != null) {}
  });
}
