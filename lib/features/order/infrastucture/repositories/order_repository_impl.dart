import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/exeptions.dart';
import 'package:pos_flutter/core/network/network_info.dart';
import 'package:pos_flutter/core/services/data_sources/local/order_local_data_source.dart';
import 'package:pos_flutter/core/services/data_sources/local/user_local_data_source.dart';
import 'package:pos_flutter/core/services/data_sources/remote/order_remote_data_source.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/core/utils/api_call_helper.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/order/domain/entities/order_detail_response.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'package:pos_flutter/features/order/domain/repositories/order_repository.dart';
import 'package:pos_flutter/features/order/infrastucture/models/order_detail_response_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';

import '../../../../core/error/failures.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final OrderLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> addOrder(OrderDetailResponse params) async {
    return await executeApiCall(() {
      return remoteDataSource.addOrder(
        OrderDetailResponseModel.fromEntity(params),
      );
    }, userLocalDataSource);
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getRemoteOrders(
      FilterOrderParams params) async {
    return await executeApiCall(() async {
      final remoteProduct = await remoteDataSource.getOrders(params);
      await localDataSource.saveOrders(remoteProduct);
      return remoteProduct;
    }, userLocalDataSource);
  }

  @override
  Future<Either<Failure, List<OrderDetails>>> getCachedOrders() async {
    try {
      final localOrders = await localDataSource.getOrders();
      return Right(localOrders);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalOrders() async {
    try {
      await localDataSource.clearOrder();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, StatistiqueOrderModel>>
      getRemoteStatistiqueOrder() async {
    return await executeApiCall(() async {
      final remoteStatisticsOrder =
          await remoteDataSource.getStatistiqueOrderModel();
      await localDataSource.saveStatistiqueOrder(remoteStatisticsOrder);
      return remoteStatisticsOrder;
    }, userLocalDataSource);
  }

  @override
  Future<Either<Failure, RevenueStatisticsModel>>
      getRemoteRevenueStatistics() async {
    return await executeApiCall(() async {
      final remoteRevenueStatistics =
          await remoteDataSource.getRevenueStatisticsModel();
      await localDataSource.saveRevenueStatistics(remoteRevenueStatistics);
      return remoteRevenueStatistics;
    }, userLocalDataSource);
  }

  @override
  Future<Either<Failure, StatistiqueOrderModel>>
      getCachedStatistiqueOrder() async {
    try {
      final localStatistiqueOrder = await localDataSource.getStatistiqueOrder();
      return Right(localStatistiqueOrder);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, RevenueStatisticsModel>>
      getCachedRevenueStatistics() async {
    try {
      final localRevenueStatistics =
          await localDataSource.getRevenueStatistics();
      return Right(localRevenueStatistics);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalStatistiqueOrder() async {
    try {
      await localDataSource.clearStatistiqueOrder();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearLocalRevenueStatistics() async {
    try {
      await localDataSource.clearRevenueStatistics();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
