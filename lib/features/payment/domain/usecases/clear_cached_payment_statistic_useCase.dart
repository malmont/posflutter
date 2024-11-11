import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/payment/domain/repositories/payment_repository.dart';

@lazySingleton
class ClearCachedPaymentStatisticUseCase
    implements UseCase<NoParams, NoParams> {
  final PaymentRepository repository;
  ClearCachedPaymentStatisticUseCase(this.repository);

  @override
  Future<Either<Failure, NoParams>> call(NoParams params) async {
    return await repository.clearPaymentStatistique();
  }
}
