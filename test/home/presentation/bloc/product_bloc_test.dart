import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jai_poc/features/home/data/repositories/product_repository.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_bloc.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_event.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductBloc', () {
    late ProductBloc productBloc;
    late MockProductRepository mockProductRepository;

    var banerImages = [
      "https://i.dummyjson.com/data/products/1/1.jpg",
      "https://i.dummyjson.com/data/products/1/2.jpg",
      "https://i.dummyjson.com/data/products/1/3.jpg",
      "https://i.dummyjson.com/data/products/1/4.jpg",
      "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
    ];

    final List<Product> tProductList = [
      Product(
        title: 'iPhone 9',
        description: 'An apple mobile which is nothing like apple',
        price: "549",
        imageUrl: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
        images: banerImages,
      )
    ];

    setUp(() {
      mockProductRepository = MockProductRepository();
      productBloc = ProductBloc();
    });

    tearDown(() {
      productBloc.close();
    });

    test('emits when getProductsList is successful', () async* {
      // Arrange
      final mockResponse = http.Response(
        jsonEncode({"products": tProductList}),
        200,
      );
      when(() => mockProductRepository.fetchProducts())
          .thenAnswer((_) async => mockResponse);

      // Act
      productBloc.add(FetchProducts());

      // Assert
      await expectLater(
        productBloc.stream,
        emitsInOrder([
          ProductLoaded(products: tProductList),
        ]),
      );
    });

    test('emits [ProductError] when getProductsList fails', () async* {
      // Arrange
      when(() => mockProductRepository.fetchProducts())
          .thenThrow(Exception('Mock error'));

      // Act
      productBloc.add(FetchProducts());

      // Assert
      await expectLater(
        productBloc.stream,
        emitsInOrder([
          ProductError('Failed to load products: Mock error'),
        ]),
      );
    });
  });
}
