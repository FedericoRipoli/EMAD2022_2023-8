import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logging/logging.dart';

import 'RestURL.dart';
import 'dto/LoginDTO.dart';
import 'dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';
import 'package:frontend_sws/util/JwtUtil.dart';


final log = Logger('UserServiceLogger');

class UserService{







  Future<TokenDto?> login(String username, String password) async {
    try{
      LoginDto loginDto=LoginDto(username,password);
      var response= await http.post(
          RestURL.login,
          body: loginDtoToJson(loginDto),
          headers: RestURL.defaultHeader
      );
      if(response.statusCode==200){
        //body contiene caratteri speciali /n/r
        TokenDto toRet=tokenDtoFromJson(response.body);
        SharedPreferencesUtils.prefs.setString(SharedPreferencesUtils.user_logged, tokenDtoToJson(toRet));
        return toRet;
      }
    }catch(e){
      log.severe(e);
    }
    return null;
  }
  Future<TokenDto?> refreshToken(TokenDto token) async{
    try{
      var response= await http.post(
          RestURL.refreshToken,
          body: tokenDtoToJson(token),
          headers: RestURL.authHeader(token.accessToken!)
      );
      if(response.statusCode==200){
        TokenDto toRet=tokenDtoFromJson(response.body);
        SharedPreferencesUtils.prefs.setString(SharedPreferencesUtils.user_logged, tokenDtoToJson(toRet));
        return toRet;
      }
    }catch(e){
      log.severe(e);
    }
    return null;
  }

  void logout(){
    SharedPreferencesUtils.prefs.remove(SharedPreferencesUtils.user_logged);
  }

  bool isLogged(){
    return SharedPreferencesUtils.prefs.containsKey(SharedPreferencesUtils.user_logged);
  }

  String? getName(){
    if(isLogged()) {
      return JwtUtil.getName(SharedPreferencesUtils.prefs.getString(SharedPreferencesUtils.user_logged)!);
    }
    return null;
  }
  bool? isAdmin(){
    if(isLogged()) {
      return JwtUtil.isAdmin(SharedPreferencesUtils.prefs.getString(SharedPreferencesUtils.user_logged)!);
    }
    return null;
  }
  bool? isExpired(){
    if(isLogged()) {
      return JwtUtil.isExpired(SharedPreferencesUtils.prefs.getString(SharedPreferencesUtils.user_logged)!);
    }
    return null;
  }


}

