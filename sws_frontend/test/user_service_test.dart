import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_sws/services/dto/SignupDTO.dart';
import 'package:frontend_sws/services/entity/Area.dart';
import 'package:frontend_sws/services/AreeService.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:frontend_sws/services/dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

void main() {
  test("Area", () async {
    AreeService u = AreeService();
    List<Area>? a=await u.ambitoList();
    if(a!=null){}
  });
}
