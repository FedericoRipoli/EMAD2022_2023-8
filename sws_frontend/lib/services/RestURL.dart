class RestURL {
  //static String baseURL = "http://localhost:8080/api/";
  //Login
  static String baseURL = "https://emadsalerno-emadsalerno.azuremicroservices.io/api/";
  static Uri login = Uri.parse("${baseURL}auth/login");
  static Uri register = Uri.parse("${baseURL}auth/register");
  static Uri refreshToken = Uri.parse("${baseURL}auth/token");

  static String utenteService = "${baseURL}users";

  static String enteService = "${baseURL}enti";
  static String areeService = "${baseURL}aree";



  static String pageabelContent="content";
  static String queryRemovePagination="paging=false";

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
