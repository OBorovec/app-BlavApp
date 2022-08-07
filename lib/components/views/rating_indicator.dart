import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppRatingIndicator extends StatelessWidget {
  final double rating;
  final double itemSize;
  const AppRatingIndicator({
    Key? key,
    required this.rating,
    this.itemSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemCount: 5,
      itemSize: itemSize,
      direction: Axis.horizontal,
    );
  }
}
