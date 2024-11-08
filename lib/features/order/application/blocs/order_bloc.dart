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
import 'package:pos_flutter/features/order/domain/usecases/clear_local_revenue_statistics_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/clear_local_statistique_order_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_cached_orders_usecase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_cached_revenue_statistics_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_cached_statistique_order_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_remote_orders_usecase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_remote_revenue_statistics_useCase.dart';
import 'package:pos_flutter/features/order/domain/usecases/get_remote_statistique_order_UseCase.dart';
import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';

part 'order_state.dart';
part 'order_event.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetRemoteOrdersUseCase _getOrdersUseCase;
  final AddOrderUseCase _addOrderUseCase;
  final GetCachedOrdersUseCase _getCachedOrdersUseCase;
  final ClearLocalOrdersUseCase _clearLocalOrdersUseCase;
  final GetRemoteRevenueStatisticsUseCase _getRemoteRevenueStatisticsUseCase;
  final GetRemoteStatistiqueOrderUseCase _getRemoteStatistiqueOrderUseCase;
  final GetCachedRevenueStatisticsUseCase _getCachedRevenueStatisticsUseCase;
  final GetCachedStatisticsOrderUseCase _getCachedStatisticsOrderUseCase;
  final ClearLocalStatisticsOrderUseCase _clearLocalStatisticsOrderUseCase;
  final ClearLocalRevenueStatisticsUseCase _clearLocalRevenueStatisticsUseCase;

  OrderBloc(
      this._getOrdersUseCase,
      this._getCachedOrdersUseCase,
      this._clearLocalOrdersUseCase,
      this._addOrderUseCase,
      this._getRemoteRevenueStatisticsUseCase,
      this._getRemoteStatistiqueOrderUseCase,
      this._getCachedRevenueStatisticsUseCase,
      this._getCachedStatisticsOrderUseCase,
      this._clearLocalStatisticsOrderUseCase,
      this._clearLocalRevenueStatisticsUseCase)
      : super(const OrderFetcInitial(orders: [], params: FilterOrderParams())) {
    on<GetOrders>(_onGetOrders);
    on<ClearLocalOrders>(_onClearLocalOrders);
    on<AddOrder>(_onAddOrder);
    on<GetStatistiqueOrder>(_onGetStatistiqueOrder);
    on<GetRevenueStatistics>(_onGetRevenueStatistics);
    on<ClearLocalStatistiqueOrder>(_onClearLocalStatistiqueOrder);
    on<ClearLocalRevenueStatistics>(_onClearLocalRevenueStatistics);
  }

  void _onGetOrders(GetOrders event, Emitter<OrderState> emit) async {
    try {
      emit(OrderFetchLoading(orders: state.orders, params: event.params));
      final cachedResult = await _getCachedOrdersUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (orders) => emit(
            const OrderFetchSuccess(orders: [], params: FilterOrderParams())),
      );
      final remoteResult = await _getOrdersUseCase(event.params);
      remoteResult.fold(
        (failure) => emit(OrderFetchFail(
            orders: state.orders, params: event.params, failure: failure)),
        (orders) =>
            emit(OrderFetchSuccess(orders: orders, params: event.params)),
      );
    } catch (e, stackTrace) {
      print('Erreur: $e, stack: $stackTrace');
      emit(OrderFetchFail(
          orders: state.orders,
          params: state.params,
          failure: ServerFailure()));
    }
  }

  void _onClearLocalOrders(
      ClearLocalOrders event, Emitter<OrderState> emit) async {
    try {
      emit(OrderFetchLoading(orders: state.orders, params: state.params));
      final cachedResult = await _clearLocalOrdersUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (result) => emit(
            const OrderFetcInitial(orders: [], params: FilterOrderParams())),
      );
    } catch (e, stackTrace) {
      print('Erreur: $e, stack: $stackTrace');
      emit(OrderFetchFail(
          orders: state.orders,
          params: state.params,
          failure: ServerFailure()));
    }
  }

  void _onAddOrder(AddOrder event, Emitter<OrderState> emit) async {
    try {
      emit(OrderFetchLoading(orders: state.orders, params: state.params));
      final result = await _addOrderUseCase(event.params);
      result.fold(
        (failure) => emit(OrderFetchFail(
            orders: state.orders, params: state.params, failure: failure)),
        (order) => emit(OrderAddSuccess(
            orders: state.orders, params: state.params, isSuccess: order)),
      );
    } catch (e, stackTrace) {
      print('Erreur: $e, stack: $stackTrace');
      emit(OrderFetchFail(
          orders: state.orders,
          params: state.params,
          failure: ServerFailure()));
    }
  }

  void _onGetStatistiqueOrder(
      GetStatistiqueOrder event, Emitter<OrderState> emit) async {
    try {
      emit(OrderFetchLoadingStatistiqueOrder(
        orders: state.orders,
        params: state.params,
      ));
      final cachedResult = await _getCachedStatisticsOrderUseCase(NoParams());
      cachedResult.fold(
        (failure) => emit(OrderFetchFailStatistiqueOrder(
            failure: failure, orders: state.orders, params: state.params)),
        (statistiqueOrder) => emit(OrderFetchSuccessStatistiqueOrder(
            statistiqueOrderModel: statistiqueOrder,
            orders: state.orders,
            params: state.params)),
      );
      final remoteResult = await _getRemoteStatistiqueOrderUseCase(NoParams());
      remoteResult.fold(
        (failure) => emit(OrderFetchFailStatistiqueOrder(
            failure: failure, orders: state.orders, params: state.params)),
        (statistiqueOrder) => emit(OrderFetchSuccessStatistiqueOrder(
            statistiqueOrderModel: statistiqueOrder,
            orders: state.orders,
            params: state.params)),
      );
    } catch (e) {
      emit(OrderFetchFailStatistiqueOrder(
          failure: ServerFailure(),
          orders: state.orders,
          params: state.params));
    }
  }

  void _onGetRevenueStatistics(
      GetRevenueStatistics event, Emitter<OrderState> emit) async {
    try {
      emit(OrderFetchLoadingRevenueStatistics(
        orders: state.orders,
        params: state.params,
      ));
      final cachedResult = await _getCachedRevenueStatisticsUseCase(NoParams());
      cachedResult.fold(
        (failure) => emit(OrderFetchFailRevenueStatistics(
            failure: failure, orders: state.orders, params: state.params)),
        (revenueStatistics) => emit(OrderFetchSuccessRevenueStatistics(
            revenueStatisticsModel: revenueStatistics,
            orders: state.orders,
            params: state.params)),
      );
      final remoteResult = await _getRemoteRevenueStatisticsUseCase(NoParams());
      remoteResult.fold(
        (failure) => emit(OrderFetchFailRevenueStatistics(
            failure: failure, orders: state.orders, params: state.params)),
        (revenueStatistics) => emit(OrderFetchSuccessRevenueStatistics(
            revenueStatisticsModel: revenueStatistics,
            orders: state.orders,
            params: state.params)),
      );
    } catch (e) {
      emit(OrderFetchFailRevenueStatistics(
          failure: ServerFailure(),
          orders: state.orders,
          params: state.params));
    }
  }

  void _onClearLocalStatistiqueOrder(
      ClearLocalStatistiqueOrder event, Emitter<OrderState> emit) async {
    try {
      final result = await _clearLocalStatisticsOrderUseCase(NoParams());
      result.fold(
        (failure) => emit(OrderFetchFailStatistiqueOrder(
            failure: failure, orders: state.orders, params: state.params)),
        (_) =>
            emit(OrderFetcInitial(orders: state.orders, params: state.params)),
      );
    } catch (e) {
      emit(OrderFetchFailStatistiqueOrder(
          failure: ServerFailure(),
          orders: state.orders,
          params: state.params));
    }
  }

  void _onClearLocalRevenueStatistics(
      ClearLocalRevenueStatistics event, Emitter<OrderState> emit) async {
    try {
      final result = await _clearLocalRevenueStatisticsUseCase(NoParams());
      result.fold(
        (failure) => emit(OrderFetchFailRevenueStatistics(
            failure: failure, orders: state.orders, params: state.params)),
        (_) =>
            emit(OrderFetcInitial(orders: state.orders, params: state.params)),
      );
    } catch (e) {
      emit(OrderFetchFailRevenueStatistics(
          failure: ServerFailure(),
          orders: state.orders,
          params: state.params));
    }
  }
}
