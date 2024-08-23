import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jai_poc/features/home/data/repositories/product_repository.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ProductRepository', () {
    late ProductRepository productRepository;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      productRepository = ProductRepository();
    });

    test('fetchProducts returns a list of products on success', () async {
      // Arrange
      final mockResponse = http.Response(
        jsonEncode({
          "products": [
            {
              "title": 'iPhone 9',
              "description": 'An apple mobile which is nothing like apple',
              "price": "549",
              "imageUrl":
                  'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
              "images": [
                "https://i.dummyjson.com/data/products/1/1.jpg",
                "https://i.dummyjson.com/data/products/1/2.jpg",
                "https://i.dummyjson.com/data/products/1/3.jpg",
                "https://i.dummyjson.com/data/products/1/4.jpg",
                "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
              ],
            }
          ]
        }),
        200,
      );

      when(() =>
              mockHttpClient.get(Uri.parse('https://dummyjson.com/products')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await productRepository.fetchProducts();

      expect(result, isNotNull);
      expect(result!.statusCode, equals(200));
    });
  });
}

// class MockProductRepository extends Mock implements ProductRepository {}
//
// void main() {
//   group('ProductBloc', () {
//     MockProductRepository mockLeadRepository = MockProductRepository();
//     var banerImages = [
//       "https://i.dummyjson.com/data/products/1/1.jpg",
//       "https://i.dummyjson.com/data/products/1/2.jpg",
//       "https://i.dummyjson.com/data/products/1/3.jpg",
//       "https://i.dummyjson.com/data/products/1/4.jpg",
//       "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
//     ];
//     final List<Product> tProductList = [
//       Product(
//         title: 'iPhone 9',
//         description: 'An apple mobile which is nothing like apple',
//         price: "549",
//         imageUrl: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
//         images: banerImages,
//       )
//     ];
//
//     test(
//         'should return a list of products with success when status code is 200',
//         () async {
//       // arrange
//       when(() => mockLeadRepository.fetchProducts())
//           .thenAnswer((_) async =>
//           // http.Response(tProductList, 200));
//           Future.value(tProductList));
//       // act
//       final result = await mockLeadRepository.fetchProducts();
//       // assert
//       expect(result, equals(tProductList));
//     });
//
//     test('should return a error 404', () async {
//       // arrange
//       when(() => mockLeadRepository.fetchProducts())
//           .thenAnswer((_) async => Future.value([]));
//       // act
//       final result = await mockLeadRepository.fetchProducts();
//       // assert
//       expect(result, equals([]));
//     });
//   });
// }
