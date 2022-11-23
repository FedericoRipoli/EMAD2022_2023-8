class RestURL {
  //static String baseURL = "http://localhost:8080/api/";
  static String baseURL = "https://emadsalerno-emadsalerno.azuremicroservices.io/api/";
  static Uri login = Uri.parse("${baseURL}auth/login");
  static Uri register = Uri.parse("${baseURL}auth/register");
  static Uri refreshToken = Uri.parse("${baseURL}auth/token");
  static Uri userService = Uri.parse("${baseURL}users");

  static var defaultHeader = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    //"Access-Control-Allow-Origin": "*"
  };

  static authHeader(String jwt) {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //"Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $jwt"
    };
  }
}
