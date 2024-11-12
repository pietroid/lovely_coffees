import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/discover/view/widgets/discover_carousel_item.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 2,
      itemBuilder: (context, index, realIndex) {
        return const DiscoverCarouselItem();
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
