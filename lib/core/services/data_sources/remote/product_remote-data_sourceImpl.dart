import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pos_flutter/core/error/exeptions.dart';
import 'package:pos_flutter/features/products/domain/entities/product/filter_product_params.dart';

import 'package:pos_flutter/features/products/infrastucture/models/product/product_response_model.dart';
import '../../api/product_api_client.dart';

abstract class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts(FilterProductParams params);
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ProductResponseModel> getProducts(FilterProductParams params) async {
    final int page =
        params.limit != null && params.limit! > 0 ? params.limit! : 1;
    final int pageSize =
        params.pageSize != null && params.pageSize! > 0 ? params.pageSize! : 12;
    final categoriesParam =
        jsonEncode(params.categories.map((e) => e.id).toList());
    const bool isPos = true;
    try {
      var response = await apiClient.getProducts(
          params.keyword ?? '', page, pageSize, categoriesParam, isPos);
      return response;
    } catch (e) {
      print('Erreur lors de la récupération des produits: $e');
      throw ServerException();
    }
  }
}
