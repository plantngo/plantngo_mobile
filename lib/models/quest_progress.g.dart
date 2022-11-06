// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quest_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestProgress _$QuestProgressFromJson(Map<String, dynamic> json) =>
    QuestProgress(
      id: json['id'] as int?,
      type: json['type'] as String?,
      countToComplete: json['countToComplete'] as int?,
      countCompleted: json['countCompleted'] as int?,
      points: json['points'] as int?,
      endDateTime: json['endDateTime'] as String?,
    );

Map<String, dynamic> _$QuestProgressToJson(QuestProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'countToComplete': instance.countToComplete,
      'countCompleted': instance.countCompleted,
      'points': instance.points,
      'endDateTime': instance.endDateTime,
    };
