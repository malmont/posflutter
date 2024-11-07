class FilterOrderParams {
  final int? orderSource;
  final int? days;

  const FilterOrderParams({
    this.orderSource = 2,
    this.days = 1,
  });

  FilterOrderParams copyWith({
    int? orderSource,
    int? days,
  }) =>
      FilterOrderParams(
        orderSource: orderSource ?? this.orderSource,
        days: days ?? this.days,
      );
}
