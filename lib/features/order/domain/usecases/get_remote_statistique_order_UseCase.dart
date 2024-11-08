import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/repositories/order_repository.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';

@lazySingleton
class GetRemoteStatistiqueOrderUseCase
    implements UseCase<StatistiqueOrderModel, NoParams> {
  final OrderRepository repository;
  GetRemoteStatistiqueOrderUseCase(this.repository);

  @override
  Future<Either<Failure, StatistiqueOrderModel>> call(NoParams params) async {
    return await repository.getRemoteStatistiqueOrder();
  }
}
