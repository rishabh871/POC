import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jai_poc/features/home/data/repositories/product_repository.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_event.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) => getProductsList(emit));
  }

  void getProductsList(Emitter<ProductState> emit) async {
    try {
      final products = await ProductRepository().fetchProducts();
      if (products != null) {
        final jsonList = json.decode(products.body);
        List<Product> finalProducts = jsonList['products'] != null
            ? List<Product>.from(
                jsonList['products']
                    .map((product) => Product.fromJson(product)),
              )
            : [];
        emit(ProductLoaded(products: finalProducts));
      }
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }
}
