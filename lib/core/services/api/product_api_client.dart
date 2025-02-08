import 'package:dio/dio.dart' hide Headers;
import 'package:pos_flutter/features/products/infrastucture/models/product/product_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String? baseUrl}) = _ProductApiClient;

  @GET('/products/by-category')
  Future<ProductResponseModel> getProducts(
    @Query('keyword') String? keyword,
    @Query('page') int page,
    @Query('pageSize') int pageSize,
    @Query('categories') String categories,
    @Query('isPos') bool isPos,
  );
}
