class User {
  String username;
  String email;
  String acctype;
  int greenPoints;
  List<String> preferences;

  User(
      {required this.username,
      required this.email,
      required this.acctype,
      required this.greenPoints,
      required this.preferences});
}
