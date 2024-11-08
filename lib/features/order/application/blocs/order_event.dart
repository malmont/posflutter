part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class GetOrders extends OrderEvent {
  final FilterOrderParams params;
  const GetOrders(this.params);

  @override
  List<Object> get props => [params];
}

class ClearLocalOrders extends OrderEvent {
  const ClearLocalOrders();

  @override
  List<Object> get props => [];
}

class AddOrder extends OrderEvent {
  final OrderDetailResponse params;
  const AddOrder(this.params);

  @override
  List<Object> get props => [params];
}

class GetStatistiqueOrder extends OrderEvent {
  const GetStatistiqueOrder();

  @override
  List<Object> get props => [];
}

class GetRevenueStatistics extends OrderEvent {
  const GetRevenueStatistics();

  @override
  List<Object> get props => [];
}

class ClearLocalStatistiqueOrder extends OrderEvent {
  const ClearLocalStatistiqueOrder();

  @override
  List<Object> get props => [];
}

class ClearLocalRevenueStatistics extends OrderEvent {
  const ClearLocalRevenueStatistics();

  @override
  List<Object> get props => [];
}
