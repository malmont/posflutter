import 'package:dio/dio.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payment_details_model.dart';
import 'package:pos_flutter/features/payment/infrastucture/models/payments_statistics_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'payment_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class PaymentApiClient {
  factory PaymentApiClient(Dio dio, {String? baseUrl}) = _PaymentApiClient;

  @GET('/payments')
  Future<List<PaymentDetailsModel>> getPayments(
    @Query('orderSource') int? orderSource,
    @Query('days') int days,
  );

  @GET('/payments/statistics/pos')
  Future<PaymentsStatisticsModel> getPaymentStatistique();
}
