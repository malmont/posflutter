import 'dart:convert';

import 'package:pos_flutter/features/authentification/domain/entities/delivery_info.dart';

DeliveryInfoModel deliveryInfoModelFromRemoteJson(String str) =>
    DeliveryInfoModel.fromJson(json.decode(str));

DeliveryInfoModel deliveryInfoModelFromLocalJson(String str) =>
    DeliveryInfoModel.fromJson(json.decode(str));

List<DeliveryInfoModel> deliveryInfoModelListFromRemoteJson(String str) =>
    List<DeliveryInfoModel>.from(
        json.decode(str).map((x) => DeliveryInfoModel.fromJson(x)));

List<DeliveryInfoModel> deliveryInfoModelListFromLocalJson(String str) =>
    List<DeliveryInfoModel>.from(
        json.decode(str).map((x) => DeliveryInfoModel.fromJson(x)));

String deliveryInfoModelToJson(DeliveryInfoModel data) =>
    json.encode(data.toJson());

String deliveryInfoModelListToJson(List<DeliveryInfoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryInfoModel extends DeliveryInfo {
  const DeliveryInfoModel({
    required String id,
    required String firstName,
    required String lastName,
    required String fullname,
    String? company, // Nullable
    required String addressLineOne,
    String? addressLineTwo, // Nullable
    required String city,
    required String zipCode,
    required String contactNumber,
    required String country,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          fullname: fullname,
          company: company ?? '',
          addressLineOne: addressLineOne,
          addressLineTwo: addressLineTwo ?? '',
          city: city,
          zipCode: zipCode,
          contactNumber: contactNumber,
          country: country,
        );

  factory DeliveryInfoModel.fromJson(Map<String, dynamic> json) {
    return DeliveryInfoModel(
      id: json["id"]?.toString() ?? '',
      firstName: json["firstname"] ?? '',
      lastName: json["lastname"] ?? '',
      fullname: json["fullname"] ?? '',
      company: json["company"] ?? '',
      addressLineOne: json["addressLineOne"] ?? '',
      addressLineTwo: json["addressLineTwo"] ?? '',
      city: json["city"] ?? '',
      zipCode: json["zipCode"]?.toString() ?? '',
      contactNumber: json["contactNumber"]?.toString() ?? '',
      country: json["country"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstName,
        "lastname": lastName,
        "fullname": fullname,
        "company": company,
        "addressLineOne": addressLineOne,
        "addressLineTwo": addressLineTwo,
        "city": city,
        "zipCode": zipCode,
        "contactNumber": contactNumber,
        "country": country,
      };

  factory DeliveryInfoModel.fromEntity(DeliveryInfo entity) =>
      DeliveryInfoModel(
        id: entity.id,
        firstName: entity.firstName,
        lastName: entity.lastName,
        fullname: entity.fullname,
        company: entity.company,
        addressLineOne: entity.addressLineOne,
        addressLineTwo: entity.addressLineTwo,
        city: entity.city,
        zipCode: entity.zipCode,
        contactNumber: entity.contactNumber,
        country: entity.country,
      );
}
