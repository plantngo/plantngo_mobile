import 'package:json_annotation/json_annotation.dart';

part 'login_form.g.dart';


@JsonSerializable()
class LoginForm {
  String? email;
  String? password;

 LoginForm({
    this.email,
    this.password,
  });

  factory LoginForm.fromJson(Map<String, dynamic> json) =>
      _$LoginFormFromJson(json);

  Map<String, dynamic> toJson() => _$LoginFormToJson(this);
}