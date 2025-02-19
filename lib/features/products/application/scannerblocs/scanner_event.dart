part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object?> get props => [];
}

class ScanProductEvent extends ScannerEvent {
  final String barcode;

  const ScanProductEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}
