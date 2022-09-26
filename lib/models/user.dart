import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String username;
  String? email;
  String? password;
  String? usertype;
  String? address;
  String token;
  int? greenPoints;
  List<String>? preferences;

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.usertype,
      required this.address,
      required this.token,
      required this.greenPoints,
      required this.preferences});

  factory User.fromJSON(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
