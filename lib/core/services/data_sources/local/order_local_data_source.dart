import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/features/order/infrastucture/models/order_details_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderDetailsModel>> getOrders();
  Future<void> saveOrders(List<OrderDetailsModel> params);
  Future<void> clearOrder();

  Future<RevenueStatisticsModel> getRevenueStatistics();
  Future<void> saveRevenueStatistics(RevenueStatisticsModel params);
  Future<void> clearRevenueStatistics();

  Future<StatistiqueOrderModel> getStatistiqueOrder();
  Future<void> saveStatistiqueOrder(StatistiqueOrderModel params);
  Future<void> clearStatistiqueOrder();
}

const cachedOrders = 'CACHED_ORDERS';
const cachedRevenueStatistics = 'CACHED_REVENUE_STATISTICS';
const cachedStatistiqueOrder = 'CACHED_STATISTIQUE_ORDER';

@LazySingleton(as: OrderLocalDataSource)
class OrderLocalDataSourceImpl implements OrderLocalDataSource {
  final SharedPreferences sharedPreferences;
  OrderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<OrderDetailsModel>> getOrders() {
    final jsonString = sharedPreferences.getString(cachedOrders);
    if (jsonString != null) {
      return Future.value(orderDetailsModelListFromLocalJson(jsonString));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveOrders(List<OrderDetailsModel> params) {
    return sharedPreferences.setString(
      cachedOrders,
      orderModelListToJson(params),
    );
  }

  @override
  Future<void> clearOrder() async {
    await sharedPreferences.remove(cachedOrders);
    return;
  }

  @override
  Future<RevenueStatisticsModel> getRevenueStatistics() {
    final jsonString = sharedPreferences.getString(cachedRevenueStatistics);
    if (jsonString != null) {
      return Future.value(
          RevenueStatisticsModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveRevenueStatistics(RevenueStatisticsModel params) {
    return sharedPreferences.setString(
      cachedRevenueStatistics,
      json.encode(params.toJson()),
    );
  }

  @override
  Future<void> clearRevenueStatistics() async {
    await sharedPreferences.remove(cachedRevenueStatistics);
    return;
  }

  @override
  Future<StatistiqueOrderModel> getStatistiqueOrder() {
    final jsonString = sharedPreferences.getString(cachedStatistiqueOrder);
    if (jsonString != null) {
      return Future.value(
          StatistiqueOrderModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> saveStatistiqueOrder(StatistiqueOrderModel params) {
    return sharedPreferences.setString(
      cachedStatistiqueOrder,
      json.encode(params.toJson()),
    );
  }

  @override
  Future<void> clearStatistiqueOrder() async {
    await sharedPreferences.remove(cachedStatistiqueOrder);
    return;
  }
}
