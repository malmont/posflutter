import 'dart:convert';

import 'package:pos_flutter/features/authentification/infrastucture/models/delivery_info_model.dart';
import 'package:pos_flutter/features/order/domain/entities/order_details.dart';
import 'order_item_model.dart';

List<OrderDetailsModel> orderDetailsModelListFromJson(String str) =>
    List<OrderDetailsModel>.from(
        json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

List<OrderDetailsModel> orderDetailsModelListFromLocalJson(String str) {
  try {
    final jsonList = json.decode(str);

    // Affiche le contenu JSON décodé pour vérifier sa structure
    print('Contenu JSON décodé : $jsonList');

    if (jsonList is List) {
      return jsonList
          .where((element) {
            // Imprime chaque élément et son type pour débogage
            print('Élément : $element, Type : ${element.runtimeType}');
            return element is Map<String, dynamic>;
          })
          .map((x) => OrderDetailsModel.fromJson(x))
          .toList();
    } else {
      throw FormatException("Le JSON fourni n'est pas une liste valide.");
    }
  } catch (e) {
    print('Erreur lors du traitement du JSON : $e');
    rethrow; // Relance l'exception pour ne pas interrompre le flux de contrôle
  }
}

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderModelListToJsonBody(List<OrderDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJsonBody())));

String orderModelListToJson(List<OrderDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJsonBody());

class OrderDetailsModel extends OrderDetails {
  const OrderDetailsModel({
    required int id,
    required String reference,
    required num totalAmount,
    required String orderDate,
    required int userId,
    required DeliveryInfoModel shippingAdress,
    required String orderSource,
    required String status,
    required List<OrderItemModel> orderItems,
  }) : super(
          id: id,
          reference: reference,
          totalAmount: totalAmount,
          orderDate: orderDate,
          userId: userId,
          shippingAdress: shippingAdress,
          orderSource: orderSource,
          status: status,
          orderItems: orderItems,
        );

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json["id"] ?? 0,
      reference: json["reference"] ?? '',
      totalAmount: json["totalAmount"] ?? 0,
      orderDate: json["orderDate"] ?? '',
      userId: json["userId"] ?? 0,
      shippingAdress: json["shippingAdress"] is Map<String, dynamic>
          ? DeliveryInfoModel.fromJson(json["shippingAdress"])
          : DeliveryInfoModel(
              id: json["shippingAdress"]?.toString() ??
                  '', // Utilise l'ID ou une valeur par défaut
              firstName: '',
              lastName: '',
              fullname: '',
              company: '',
              addressLineOne: '',
              addressLineTwo: '',
              city: '',
              zipCode: '',
              contactNumber: '',
              country: '',
            ),
      orderSource: json["orderSource"] ?? '',
      status: json["status"] ?? '',
      orderItems: json["orderItems"] != null
          ? List<OrderItemModel>.from(
              json["orderItems"].map((x) => OrderItemModel.fromJson(x)))
          : [],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "totalAmount": totalAmount,
        "orderDate": orderDate,
        "userId": userId,
        "shippingAdress": shippingAdress.toJson(),
        "orderSource": orderSource,
        "status": status,
        "orderItems": List<dynamic>.from(
            (orderItems as List<OrderItemModel>).map((x) => x.toJson())),
      };

  Map<String, dynamic> toJsonBody() => {
        "id": id,
        "reference": reference,
        "totalAmount": totalAmount,
        "orderDate": orderDate,
        "userId": userId,
        "shippingAdress": shippingAdress.toJson(),
        "orderSource": orderSource,
        "status": status,
        "orderItems": List<dynamic>.from(
            (orderItems as List<OrderItemModel>).map((x) => x.toJsonBody())),
      };

  factory OrderDetailsModel.fromEntity(OrderDetails entity) =>
      OrderDetailsModel(
        id: entity.id,
        reference: entity.reference,
        totalAmount: entity.totalAmount,
        orderDate: entity.orderDate,
        userId: entity.userId,
        shippingAdress: DeliveryInfoModel.fromEntity(entity.shippingAdress),
        orderSource: entity.orderSource,
        status: entity.status,
        orderItems: entity.orderItems
            .map((orderItem) => OrderItemModel.fromEntity(orderItem))
            .toList(),
      );
}
