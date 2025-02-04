// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantModel _$VariantModelFromJson(Map<String, dynamic> json) => VariantModel(
      id: (json['id'] as num).toInt(),
      color: json['color'] == null
          ? null
          : ColorModel.fromJson(json['color'] as Map<String, dynamic>),
      size: json['size'] == null
          ? null
          : SizeModel.fromJson(json['size'] as Map<String, dynamic>),
      stockQuantity: (json['stockQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$VariantModelToJson(VariantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stockQuantity': instance.stockQuantity,
      'color': instance.color?.toJson(),
      'size': instance.size?.toJson(),
    };
