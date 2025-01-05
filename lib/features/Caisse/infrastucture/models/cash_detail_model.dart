import 'dart:convert';
import 'package:pos_flutter/features/Caisse/domain/entities/cash_detail.dart';

class CashDetailModel extends CashDetail {
  const CashDetailModel({
    required super.typeCash,
    required super.value,
    required super.nombreItems,
    required super.total,
  });

  factory CashDetailModel.fromJson(Map<String, dynamic> json) {
    return CashDetailModel(
      typeCash: json["typeCash"],
      value: json["value"],
      nombreItems: json["nombreItems"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "typeCash": typeCash,
        "value": value,
        "nombreItems": nombreItems,
        "total": total,
      };

  factory CashDetailModel.fromEntity(CashDetail cashDetail) {
    return CashDetailModel(
      typeCash: cashDetail.typeCash,
      value: cashDetail.value,
      nombreItems: cashDetail.nombreItems,
      total: cashDetail.total,
    );
  }

  CashDetail toEntity() {
    return CashDetail(
      typeCash: typeCash,
      value: value,
      nombreItems: nombreItems,
      total: total,
    );
  }
}
