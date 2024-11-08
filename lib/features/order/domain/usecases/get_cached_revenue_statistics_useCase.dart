import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/repositories/order_repository.dart';
import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';

@lazySingleton
class GetCachedRevenueStatisticsUseCase
    implements UseCase<RevenueStatisticsModel, NoParams> {
  final OrderRepository repository;
  GetCachedRevenueStatisticsUseCase(this.repository);

  @override
  Future<Either<Failure, RevenueStatisticsModel>> call(NoParams params) async {
    return await repository.getCachedRevenueStatistics();
  }
}
