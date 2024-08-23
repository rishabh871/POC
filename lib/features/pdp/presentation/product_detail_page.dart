import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';
import 'package:jai_poc/features/pdp/presentation/feature_screen.dart';
import 'package:jai_poc/features/pdp/presentation/specification_screen.dart';
import 'package:jai_poc/core/widgets/custom-app_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({
    required this.product,
  });

  var options = {
    'key': 'rzp_test_sCABIfBX2k8SlQ',
    'amount': 100,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'retry': {'enabled': true, 'max_count': 10},
    'send_sms_hash': true,
    'prefill': {'contact': '9585276592', 'email': 'test@razorpay.com'},
    'external': {
      'wallets': ['paytm']
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product Detail',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            SizedBox(
              height: 200,
              child: CarouselSlider(
                items: product.images.map((imageUrl) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Price: \$${product.price}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 4.0),
                        const Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton(
                            child: const Text(
                              "Pay Now",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Features'),
                      Tab(text: 'Specifications'),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FeatureItem(label: 'Brand', value: 'Apple'),
                                FeatureItem(
                                    label: 'Category', value: 'Smartphones'),
                                FeatureItem(label: 'Price', value: '\$5.49'),
                                FeatureItem(
                                    label: 'Sale Price', value: '\$4.69'),
                                FeatureItem(label: 'Rating', value: '4.69'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SpecificationScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
