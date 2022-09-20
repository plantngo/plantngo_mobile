import 'package:json_annotation/json_annotation.dart';

part 'form_data.g.dart';


@JsonSerializable()
class FormData {
  String? email;
  String? password;
  bool passwordVisible;

  FormData({
    this.email,
    this.password,
    this.passwordVisible = true,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}