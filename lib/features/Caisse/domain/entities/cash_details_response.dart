class CashDetailResponse {
  final int typeCash; // ID du TypeCash
  final int nombreItems;

  const CashDetailResponse({
    required this.typeCash,
    required this.nombreItems,
  });

  CashDetailResponse copyWith({
    int? typeCash,
    int? nombreItems,
  }) {
    return CashDetailResponse(
      typeCash: typeCash ?? this.typeCash,
      nombreItems: nombreItems ?? this.nombreItems,
    );
  }

  @override
  String toString() {
    return 'CashDetailResponse(typeCash: $typeCash, nombreItems: $nombreItems)';
  }
}
