import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/repositories/order_repository.dart';

@lazySingleton
class ClearLocalStatisticsOrderUseCase implements UseCase<NoParams, NoParams> {
  final OrderRepository repository;
  ClearLocalStatisticsOrderUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.clearLocalStatistiqueOrder();
  }
}
