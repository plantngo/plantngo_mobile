import 'package:json_annotation/json_annotation.dart';

part 'rewards.g.dart';

@JsonSerializable()
class Rewards {
  int? id;
  String? name;
  String? description;
  double? price;
  Rewards({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
  factory Rewards.fromJSON(Map<String, dynamic> json) =>
      _$RewardsFromJson(json);

  Map<String, dynamic> toJSON() => _$RewardsToJson(this);
}
