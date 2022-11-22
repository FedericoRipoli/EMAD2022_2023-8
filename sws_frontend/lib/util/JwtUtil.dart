import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtil{
  static const String exp='exp';
  static const String role='role';
  static const String name='name';

  static Map<String, dynamic> decode(String jwt){
    return JwtDecoder.decode(jwt);
  }

  static bool isAdmin(String jwt){
    Map<String,dynamic> result=decode(jwt);
    return result[role]=="ADMIN";
  }

  static String getName(String jwt){
    Map<String,dynamic> result=decode(jwt);
    return result[name];
  }

  static bool isExpired(String jwt){
    Map<String,dynamic> result=decode(jwt);
    DateTime expDate = result[exp];
    DateTime now=DateTime.now();
    return expDate.compareTo(now)>0;
  }
}
