import 'package:pos_flutter/features/Caisse/domain/entities/cash_details_response.dart';

class CashDetailResponseModel extends CashDetailResponse {
  const CashDetailResponseModel({
    required super.typeCash,
    required super.nombreItems,
  });

  factory CashDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return CashDetailResponseModel(
      typeCash: json["typeCash"],
      nombreItems: json["nombreItems"],
    );
  }

  Map<String, dynamic> toJson() => {
        "typeCash": typeCash,
        "nombreItems": nombreItems,
      };

  factory CashDetailResponseModel.fromEntity(CashDetailResponse cashDetail) {
    return CashDetailResponseModel(
      typeCash: cashDetail.typeCash,
      nombreItems: cashDetail.nombreItems,
    );
  }

  @override
  CashDetailResponseModel copyWith({
    int? typeCash,
    int? nombreItems,
  }) {
    return CashDetailResponseModel(
      typeCash: typeCash ?? this.typeCash,
      nombreItems: nombreItems ?? this.nombreItems,
    );
  }
}
