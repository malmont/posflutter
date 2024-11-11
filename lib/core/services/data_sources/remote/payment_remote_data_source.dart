import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/exeptions.dart';
import 'package:pos_flutter/core/services/api/payment_api_client.dart';
import 'package:pos_flutter/features/order/domain/entities/filter_order_params.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payment_details_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentDetailsModel>> getPayments(FilterOrderParams params);
  Future<PaymentsStatisticsModel> getPaymentStatistique();
}

@LazySingleton(as: PaymentRemoteDataSource)
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final PaymentApiClient apiClient;

  PaymentRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PaymentDetailsModel>> getPayments(
      FilterOrderParams params) async {
    final int orderSource =
        params.orderSource != null && params.orderSource! > 0
            ? params.orderSource!
            : 1;
    final int days = params.days != null && params.days! > 0 ? params.days! : 7;
    try {
      final response = await apiClient.getPayments(
        orderSource,
        days,
      );
      return response;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<PaymentsStatisticsModel> getPaymentStatistique() async {
    try {
      final response = await apiClient.getPaymentStatistique();
      return response;
    } catch (e) {
      throw ServerException();
    }
  }
}
