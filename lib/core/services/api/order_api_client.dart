import 'package:dio/dio.dart';
import 'package:pos_flutter/features/order/infrastucture/models/order_detail_response_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/order_details_model.dart';
import 'package:retrofit/retrofit.dart';

part 'order_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class OrderApiClient {
  factory OrderApiClient(Dio dio, {String? baseUrl}) = _OrderApiClient;

  @GET('/orders')
  Future<List<OrderDetailsModel>> getOrders(
    @Query('orderSource') int? orderSource,
    @Query('days') int days,
  );

  @POST('/order/create-multi-payment')
  Future<HttpResponse> createOrder(@Body() OrderDetailResponseModel params);
}
