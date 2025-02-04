part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerLoaded extends ScannerState {
  final Product product;

  const ScannerLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ScannerError extends ScannerState {
  final Failure failure;

  const ScannerError(this.failure);

  @override
  List<Object?> get props => [failure];
}
