import 'package:dartz/dartz.dart';
import 'package:pos_flutter/core/error/failures.dart';
import 'package:pos_flutter/core/usecases/usecases.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/payment/domain/entities/payment_details.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, List<PaymentDetails>>> getPayments(
      FilterOrderParams params);
  Future<Either<Failure, List<PaymentDetails>>> getCachedPayments();
  Future<Either<Failure, PaymentsStatisticsModel>> getPaymentStatistique();
  Future<Either<Failure, PaymentsStatisticsModel>>
      getCachedPaymentStatistique();
  Future<Either<Failure, NoParams>> clearPaymentStatistique();
}
