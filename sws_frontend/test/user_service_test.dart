import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_sws/services/UserService.dart';
import 'package:frontend_sws/services/dto/TokenDTO.dart';
import 'package:frontend_sws/util/SharedPreferencesUtils.dart';

void main() {
  test("Login" , () async{
    await SharedPreferencesUtils.init();
    var service=UserService();
    print(await service.login("admin", "admin"));

  });
  test("Refresh token" , () async{
    var service=UserService();
    print(await service.refreshToken(TokenDto(
      accessToken: "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIyIiwicm9sZSI6IiIsImlzcyI6InN3cyIsIm5hbWUiOiJhZG1pbjIiLCJleHAiOjE2NjkwNDYxMTAsImlhdCI6MTY2OTA0NjA1MH0.z2MIOnqqRl1zvI9a54RuU2yBbq9HTRMXYcahtoAm8brXXELzQPJ2w8RJNe8hum8ggQVBxfKMI2kyXd-MP0lyXF8rPsJmDLQG7zpiGGQaQa3Pp7-c9Iosqj4bCX7ppiLDL0xhF_OctU72St8nTi0iNQeYLCM2mhcMbggKLyka9ifszeLkwlKkaGSIa2adFh2AooZazCBbzEdRtrPAl3W9ytiGlBdlKnNHSt0onquaKAjFADdm8_-cwm9-pxZMgd9UGXDQ27fsgbEnC4t4yOFNHqeMPMW8WhQ2KSuMb3wX4ow9HPO64EMIg9__r_G4SAXCR-AhxrhoD7t1G8YALghPMA",
      refreshToken: "eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIyIiwicm9sZSI6IiIsImlzcyI6InN3cyIsIm5hbWUiOiJhZG1pbjIiLCJleHAiOjE2NzE2MzgwNTAsImlhdCI6MTY2OTA0NjA1MH0.DtBgzlj1YhZG5xa6ILxSc5kPuS06o6oaUXIS1N-43VnNWK51ybC3B2pCTB92JnbewhbUQG1ExtywqgSATcBg0cxF4Dg5J47GVa7vUU0h0Mk9qAmCG-B6NipgSSB-eYij57E0iD3rNHaQIaN6LR9jUsQ3eh2t1ix8OoRQcS3gYkHL0UfEKpbfnE1aGSTLahADoVgcRF0nksPwwVpS423xrHoKaXfyxKwgjVAakrvFsFtuVYRcqoSlQGPKukfpRt4IiTimY0TrJ1UXynTu1bP0Rx0vix-KT7hVv_7FAwY_DaCsDCThcPd-Jinoi_tUaONRdh0rbWx179GBtlG2YdoeMg",
      userId: "2"
    )));

  });

}
