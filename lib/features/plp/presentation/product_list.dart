import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jai_poc/features/home/domain/entities/product.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_event.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_state.dart';
import 'package:jai_poc/features/pdp/presentation/product_detail_page.dart';
import 'package:jai_poc/core/widgets/custom-app_bar.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemBloc = BlocProvider.of<ProductBloc>(context);
    itemBloc.add(FetchProducts());

    return Scaffold(
      appBar: CustomAppBar(title: 'Product Listing', showBackButton: true),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ProductGrid(products: state.products);
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No Data Found!"));
          }
        },
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cards in each row
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                          product: product,
                        )),
              );
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                  height: 110.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: product.imageUrl,
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2.0),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
