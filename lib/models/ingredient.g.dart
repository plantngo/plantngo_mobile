// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as int?,
      ingredientId: json['ingredientId'] as String?,
      category: json['category'] as String?,
      name: json['name'] as String?,
      emissionPerGram: (json['emissionPerGram'] as num?)?.toDouble(),
      servingWeight: (json['servingWeight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ingredientId': instance.ingredientId,
      'name': instance.name,
      'category': instance.category,
      'emissionPerGram': instance.emissionPerGram,
      'servingWeight': instance.servingWeight,
    };
