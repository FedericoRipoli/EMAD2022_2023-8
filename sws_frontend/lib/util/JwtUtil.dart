import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtil{
  static const String exp='exp';
  static const String role='role';
  static const String name='name';
  static const String ente='ente';
  static const String idEnte='idEnte';

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
  static String getIdEnte(String jwt){
    Map<String,dynamic> result=decode(jwt);
    return result.containsKey(idEnte)? result[idEnte]:null;
  }
  static String getEnte(String jwt){
    Map<String,dynamic> result=decode(jwt);
    return result.containsKey(ente)? result[ente]:null;
  }

  static bool isExpired(String jwt){
    Map<String,dynamic> result=decode(jwt);
    DateTime expDate = DateTime.fromMillisecondsSinceEpoch(result[exp] * 1000);
    DateTime now=DateTime.now();
    return now.compareTo(expDate)>0;
  }
}
