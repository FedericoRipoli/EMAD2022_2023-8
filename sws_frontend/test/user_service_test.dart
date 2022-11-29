import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Ambito.dart';
import 'package:frontend_sws/services/AmbitoService.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:frontend_sws/services/dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

void main() {
  test("Ambito", () async {
    AmbitoService u = AmbitoService();
    List<Ambito>? a=await u.ambitoList();
    if(a!=null){}
  });
}
