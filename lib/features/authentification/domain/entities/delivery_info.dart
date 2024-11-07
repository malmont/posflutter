import 'package:equatable/equatable.dart';

class DeliveryInfo extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String fullname;
  final String? company;
  final String addressLineOne;
  final String? addressLineTwo;
  final String city;
  final String zipCode;
  final String contactNumber;
  final String country;

  const DeliveryInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullname,
    this.company,
    required this.addressLineOne,
    this.addressLineTwo,
    required this.city,
    required this.zipCode,
    required this.contactNumber,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "fullname": fullname,
      "company": company,
      "addressLineOne": addressLineOne,
      "addressLineTwo": addressLineTwo,
      "city": city,
      "zipCode": zipCode,
      "contactNumber": contactNumber,
      "country": country,
    };
  }

  @override
  List<Object?> get props => [id];
}
