class Utente {
  final String username, password;
  final String? idEnte, ente;
  final bool admin;

  Utente({required this.username,required this.password, this.idEnte, this.ente,required this.admin});
}