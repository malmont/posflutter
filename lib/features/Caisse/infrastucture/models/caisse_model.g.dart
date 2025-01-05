// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caisse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaisseModel _$CaisseModelFromJson(Map<String, dynamic> json) => CaisseModel(
      id: (json['id'] as num).toInt(),
      amountTotal: (json['amountTotal'] as num).toDouble(),
      fondDeCaisse: (json['fondDeCaisse'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String,
      isOpen: json['isOpen'] as bool,
      transactionCaisses: (json['transactionCaisses'] as List<dynamic>)
          .map(
              (e) => TransactionCaisseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CaisseModelToJson(CaisseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amountTotal': instance.amountTotal,
      'fondDeCaisse': instance.fondDeCaisse,
      'createdAt': instance.createdAt,
      'isOpen': instance.isOpen,
      'transactionCaisses': instance.transactionCaisses,
    };
