import 'package:pos_flutter/features/order/infrastucture/models/revenue_statistics_model.dart';
import 'package:pos_flutter/features/order/infrastucture/models/statistique_order_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'statistique_order_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class StatistiqueOrderApiClient {
  factory StatistiqueOrderApiClient(Dio dio, {String? baseUrl}) =
      _StatistiqueOrderApiClient;

  @GET('/statistiques/chiffre-affaires/pos')
  Future<RevenueStatisticsModel> getStatistiqueRevenue();

  @GET('/statistiques/nombre-commandes/pos')
  Future<StatistiqueOrderModel> getStatistiqueOrderTotal();
}
