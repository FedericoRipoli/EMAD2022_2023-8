class RestURL {


  static String baseURL = "http://localhost:8080/api/";

  static Uri login = Uri.parse("${baseURL}auth/login");
  static Uri register = Uri.parse("${baseURL}auth/register");
  static Uri refreshToken = Uri.parse("${baseURL}auth/token");

  static String utenteService = "${baseURL}users";

  static String enteService = "${baseURL}enti";
  static String areeService = "${baseURL}aree";
  static String struttureService = "${baseURL}strutture";
  static String struttureEnteService = "${baseURL}struttureente";
  static String servizioService = "${baseURL}servizi";
  static String defibrillatoriService = "${baseURL}defibrillatori";
  static String editStatoServizioService = "${baseURL}statoservizio";
  static String eventoService = "${baseURL}eventi";
  static String impostazioniService = "${baseURL}impostazioni";

  static Uri oliviaService = Uri.parse("ws://192.168.178.21:8081/websocket");

  static String pageabelContent = "content";
  static String queryRemovePagination = "paging=false";

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
