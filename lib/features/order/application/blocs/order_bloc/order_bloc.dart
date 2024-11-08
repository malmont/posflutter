import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_detail_response.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/domain/usecases/add_order_usecase.dart';
import 'package:pos_flutter/features/order/domain/usecases/clear_local_order_usecase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_cached_orders_usecase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_remote_orders_usecase.dart';

part 'order_state.dart';
part 'order_event.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetRemoteOrdersUseCase _getOrdersUseCase;
  final AddOrderUseCase _addOrderUseCase;
  final GetCachedOrdersUseCase _getCachedOrdersUseCase;
  final ClearLocalOrdersUseCase _clearLocalOrdersUseCase;

  OrderBloc(
    this._getOrdersUseCase,
    this._getCachedOrdersUseCase,
    this._clearLocalOrdersUseCase,
    this._addOrderUseCase,
  ) : super(OrderInitial()) {
    on<GetOrders>(_onGetOrders);
    on<ClearLocalOrders>(_onClearLocalOrders);
    on<AddOrder>(_onAddOrder);
  }

  // Gestion des commandes
  Future<void> _onGetOrders(GetOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoadInProgress());
    final cachedResult = await _getCachedOrdersUseCase(NoParams());
    cachedResult.fold(
      (failure) => emit(OrderLoadFailure(failure)),
      (orders) => emit(OrderLoadSuccess(orders)),
    );
    final remoteResult = await _getOrdersUseCase(event.params);
    remoteResult.fold(
      (failure) => emit(OrderLoadFailure(failure)),
      (orders) => emit(OrderLoadSuccess(orders)),
    );
  }

  Future<void> _onClearLocalOrders(
      ClearLocalOrders event, Emitter<OrderState> emit) async {
    final result = await _clearLocalOrdersUseCase(NoParams());
    result.fold(
      (failure) => emit(OrderLoadFailure(failure)),
      (_) => emit(OrderInitial()),
    );
  }

  Future<void> _onAddOrder(AddOrder event, Emitter<OrderState> emit) async {
    emit(OrderAddInProgress());
    final result = await _addOrderUseCase(event.params);
    result.fold(
      (failure) => emit(OrderAddFailure(failure)),
      (_) => emit(const OrderAddSuccess(true)),
    );
  }
}
