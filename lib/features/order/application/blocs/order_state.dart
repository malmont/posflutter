part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  final List<OrderDetails> orders;
  final FilterOrderParams params;
  const OrderState({
    required this.orders,
    required this.params,
  });
  @override
  List<Object> get props => [orders, params];
}

class OrderFetcInitial extends OrderState {
  const OrderFetcInitial({
    required super.orders,
    required super.params,
  });
}

class OrderFetchLoading extends OrderState {
  const OrderFetchLoading({
    required super.orders,
    required super.params,
  });
}

class OrderFetchSuccess extends OrderState {
  const OrderFetchSuccess({
    required super.orders,
    required super.params,
  });
}

class OrderAddLoading extends OrderState {
  const OrderAddLoading({
    required super.orders,
    required super.params,
  });
}

class OrderAddSuccess extends OrderState {
  final bool isSuccess;
  const OrderAddSuccess({
    required this.isSuccess,
    required super.orders,
    required super.params,
  });

  @override
  List<Object> get props => [isSuccess, orders, params];
}

class OrderAddFail extends OrderState {
  const OrderAddFail({
    required super.orders,
    required super.params,
  });
}

class OrderFetchFail extends OrderState {
  final Failure failure;
  const OrderFetchFail({
    required super.orders,
    required super.params,
    required this.failure,
  });
  @override
  List<Object> get props => [failure];
}

class OrderFetchLoadingStatistiqueOrder extends OrderState {
  const OrderFetchLoadingStatistiqueOrder({
    required super.orders,
    required super.params,
  });
}

class OrderFetchLoadingRevenueStatistics extends OrderState {
  const OrderFetchLoadingRevenueStatistics({
    required super.orders,
    required super.params,
  });
}

class OrderFetchSuccessStatistiqueOrder extends OrderState {
  final StatistiqueOrderModel statistiqueOrderModel;
  const OrderFetchSuccessStatistiqueOrder({
    required this.statistiqueOrderModel,
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [statistiqueOrderModel, orders, params];
}

class OrderFetchSuccessRevenueStatistics extends OrderState {
  final RevenueStatisticsModel revenueStatisticsModel;
  const OrderFetchSuccessRevenueStatistics({
    required this.revenueStatisticsModel,
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [revenueStatisticsModel, orders, params];
}

class OrderFetchFailStatistiqueOrder extends OrderState {
  final Failure failure;
  const OrderFetchFailStatistiqueOrder({
    required this.failure,
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [failure, orders, params];
}

class OrderFetchFailRevenueStatistics extends OrderState {
  final Failure failure;
  const OrderFetchFailRevenueStatistics({
    required this.failure,
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [failure, orders, params];
}
