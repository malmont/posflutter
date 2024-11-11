import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/payment/domain/repositories/payment_repository.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';

@lazySingleton
class GetCachedPaymentStatisticUsecase
    implements UseCase<PaymentsStatisticsModel, NoParams> {
  final PaymentRepository repository;
  GetCachedPaymentStatisticUsecase(this.repository);

  @override
  Future<Either<Failure, PaymentsStatisticsModel>> call(NoParams params) async {
    return await repository.getCachedPaymentStatistique();
  }
}
