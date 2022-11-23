import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';

import 'RestURL.dart';
import 'dto/LoginDTO.dart';
import 'dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';
import 'package:frontend_sws/util/JwtUtil.dart';


class UserService {

  final log = Logger('UserServiceLogger');
  Future<String?> getUser() async {
    if (isLogged()) {
      TokenDto? token = tokenDtoFromJson(SharedPreferencesUtils.prefs
          .getString(SharedPreferencesUtils.userLogged)!);
      bool? exp = isExpired();
      if (exp != null && exp) {
        token = await refreshToken(token);
      }
      return token?.accessToken;
    }
    return null;
  }

  Future<TokenDto?> login(String username, String password) async {
    try {
      LoginDto loginDto = LoginDto(username, password);
      var response = await http.post(RestURL.login,
          body: loginDtoToJson(loginDto), headers: RestURL.defaultHeader);

      if (response.statusCode == 200) {
        //body contiene caratteri speciali /n/r
        TokenDto toRet = tokenDtoFromJson(response.body);
        SharedPreferencesUtils.prefs.setString(
            SharedPreferencesUtils.userLogged, tokenDtoToJson(toRet));
        return toRet;
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  Future<TokenDto?> refreshToken(TokenDto token) async {
    try {
      var response = await http.post(RestURL.refreshToken,
          body: tokenDtoToJson(token),
          headers: RestURL.authHeader(token.accessToken!));
      if (response.statusCode == 200) {
        TokenDto toRet = tokenDtoFromJson(response.body);
        SharedPreferencesUtils.prefs.setString(
            SharedPreferencesUtils.userLogged, tokenDtoToJson(toRet));
        return toRet;
      }
    } catch (e) {
      log.severe(e);
    }
    return null;
  }

  String? getToken(){
    if (isLogged()) {
      TokenDto? token = tokenDtoFromJson(SharedPreferencesUtils.prefs
          .getString(SharedPreferencesUtils.userLogged)!);
      return token.accessToken;
    }
    return null;
  }
  void logout() {
    SharedPreferencesUtils.prefs.remove(SharedPreferencesUtils.userLogged);
  }

  bool isLogged() {
    return SharedPreferencesUtils.prefs
        .containsKey(SharedPreferencesUtils.userLogged);
  }

  String? getName() {
    if (isLogged()) {
      return JwtUtil.getName(getToken()!);
    }
    return null;
  }

  bool? isAdmin() {
    if (isLogged()) {
      return JwtUtil.isAdmin(getToken()!);
    }
    return null;
  }

  bool? isExpired() {
    if (isLogged()) {
      return JwtUtil.isExpired(getToken()!);
    }
    return null;
  }
}
