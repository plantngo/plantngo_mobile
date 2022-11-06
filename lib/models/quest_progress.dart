import 'package:json_annotation/json_annotation.dart';

part 'quest_progress.g.dart';

@JsonSerializable()
class QuestProgress {
  int? id;
  String? type;
  int? countToComplete;
  int? countCompleted;
  int? points;
  String? endDateTime;

  QuestProgress({
    required this.id,
    required this.type,
    required this.countToComplete,
    required this.countCompleted,
    required this.points,
    required this.endDateTime,
  });

  factory QuestProgress.fromJson(Map<String, dynamic> json) =>
      _$QuestProgressFromJson(json);

  Map<String, dynamic> toJson() => _$QuestProgressToJson(this);
}
