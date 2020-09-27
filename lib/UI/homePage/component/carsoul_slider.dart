import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class BuildCarsoulSlider extends StatelessWidget {
  final List carsoulImages = [
    'assets/c1.jpg',
    'assets/m1.jpeg',
    'assets/m2.jpg',
    'assets/w1.jpeg',
    'assets/w3.jpeg',
    'assets/w4.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      width: width,
      child: Carousel(
        images: carsoulImages
            .map(
              (item) => Image.asset(
                item,
                fit: BoxFit.cover,
              ),
            )
            .toList(),
        dotBgColor: Colors.brown.withOpacity(0.1),
        dotColor: Colors.brown.withOpacity(0.7),
        dotSize: 6,
        indicatorBgPadding: 7,
      ),
    );
  }
}
