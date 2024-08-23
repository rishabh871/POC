import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoScrollingCarousel extends StatelessWidget {
  final List<String> images;

  const AutoScrollingCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        items: images.map((imageUrl) {
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
    );
  }
}
