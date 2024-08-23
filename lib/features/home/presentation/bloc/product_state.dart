import 'package:equatable/equatable.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';

abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({ required this.products});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}
