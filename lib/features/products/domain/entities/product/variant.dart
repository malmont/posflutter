import 'package:equatable/equatable.dart';
import 'color.dart';
import 'size.dart';

class Variant extends Equatable {
  final int id;
  final Color? color;
  final Size? size;
  final int stockQuantity;

  const Variant({
    required this.id,
    required this.color,
    required this.size,
    required this.stockQuantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "color": (color as dynamic)
          ?.toJson(), // assuming Color also has a toJson method
      "size":
          (size as dynamic)?.toJson(), // assuming Size also has a toJson method
      "stockQuantity": stockQuantity,
    };
  }

  @override
  List<Object?> get props => [id, color, size, stockQuantity];
}
