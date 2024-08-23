import 'package:http/http.dart' as http;

class ProductRepository {
  Future<http.Response?> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      try {
        return response;
      } catch (e) {
        return null;
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
