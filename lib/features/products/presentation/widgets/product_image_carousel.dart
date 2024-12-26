import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/features/products/domain/entities/product/product.dart';

class ProductImageCarousel extends StatelessWidget {
  final Product product;
  final int currentIndex;
  final Function(int) onPageChanged;

  const ProductImageCarousel({
    super.key,
    required this.product,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: CachedNetworkImage(
            imageUrl: product.image,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 330,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: CachedNetworkImage(
            imageUrl: product.image,
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 285,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) => onPageChanged(index),
      ),
    );
  }
}
