import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/network/network_info.dart';
import 'package:pos_flutter/core/services/data_sources/local/payment_local_data_source.dart';
import 'package:pos_flutter/core/services/data_sources/local/user_local_data_source.dart';
import 'package:pos_flutter/core/services/data_sources/remote/payment_remote_data_source.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/core/utils/api_call_helper.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/payment/domain/entities/payment_details.dart';
import 'package:pos_flutter/features/payment/domain/repositories/payment_repository.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';

@LazySingleton(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final PaymentLocalDataSource localDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  PaymentRepositoryImpl(
    this.userLocalDataSource, {
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PaymentDetails>>> getPayments(
      FilterOrderParams params) async {
    return await executeApiCall(() async {
      final remoteProduct = await remoteDataSource.getPayments(params);
      await localDataSource.savePayment(remoteProduct);
      return remoteProduct;
    }, userLocalDataSource);
  }

  @override
  Future<Either<Failure, List<PaymentDetails>>> getCachedPayments() async {
    try {
      final localProduct = await localDataSource.getPayments();
      return Right(localProduct);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> clearPaymentStatistique() async {
    try {
      await localDataSource.clearPaymentStatistique();
      return Right(NoParams());
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, PaymentsStatisticsModel>>
      getPaymentStatistique() async {
    return await executeApiCall(() async {
      final remoteProduct = await remoteDataSource.getPaymentStatistique();
      await localDataSource.savePaymentStatistique(remoteProduct);
      return remoteProduct;
    }, userLocalDataSource);
  }

  @override
  Future<Either<Failure, PaymentsStatisticsModel>>
      getCachedPaymentStatistique() async {
    try {
      final localProduct = await localDataSource.getPaymentStatistique();
      return Right(localProduct);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
