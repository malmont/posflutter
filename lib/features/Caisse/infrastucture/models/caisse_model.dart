import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:pos_flutter/features/Caisse/domain/entities/caisse.dart';
import 'transaction_caisse_model.dart';

part 'caisse_model.g.dart';

@JsonSerializable()
class CaisseModel extends Caisse {
  @override
  final List<TransactionCaisseModel> transactionCaisses;

  CaisseModel({
    required int id,
    required double amountTotal,
    double? fondDeCaisse, // Rend fondDeCaisse nullable
    required String createdAt,
    required bool isOpen,
    required this.transactionCaisses,
  }) : super(
            id: id,
            amountTotal: amountTotal,
            fondDeCaisse: fondDeCaisse ?? 0.0, // Valeur par défaut si null
            createdAt: createdAt,
            isOpen: isOpen,
            transactionCaisses: transactionCaisses);

  factory CaisseModel.fromEntity(Caisse entity) => CaisseModel(
        id: entity.id,
        amountTotal: entity.amountTotal,
        fondDeCaisse:
            entity.fondDeCaisse, // Pas besoin de valeur par défaut ici
        createdAt: entity.createdAt,
        isOpen: entity.isOpen,
        transactionCaisses: entity.transactionCaisses
            .map(
                (transaction) => TransactionCaisseModel.fromEntity(transaction))
            .toList(),
      );

  factory CaisseModel.fromJson(Map<String, dynamic> json) => CaisseModel(
        id: json['id'],
        amountTotal: (json['amountTotal'] as num).toDouble(),
        fondDeCaisse: json['fonDeCaisse'] != null
            ? (json['fonDeCaisse'] as num).toDouble()
            : 0.0, // Valeur par défaut si null
        createdAt: json['createdAt'],
        isOpen: json['isOpen'],
        transactionCaisses: (json['transactionCaisses'] as List<dynamic>)
            .map((x) =>
                TransactionCaisseModel.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => _$CaisseModelToJson(this);
}

List<CaisseModel> caisseModelListFromLocalJson(String str) =>
    List<CaisseModel>.from(
        json.decode(str).map((x) => CaisseModel.fromJson(x)));

String caisseModelListToJson(List<CaisseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
