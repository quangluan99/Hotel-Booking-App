import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final double rating;
  const StarRating({super.key, required this.rating});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  final Color _filledColor = Colors.amber;
  final Color _emptyColor = Colors.black26;

  Widget myStar(bool filled, [bool isHalf = false]) {
    return Icon(
      isHalf ? Icons.star_half : Icons.star,
      size: 15.0,
      color: filled ? _filledColor : _emptyColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double safeRating = widget.rating.clamp(0.0, 5.0);
    final int fullStars = safeRating.floor();
    final bool hasHalfStar = (safeRating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return myStar(true);
        } else if (index == fullStars && hasHalfStar) {
          return myStar(true, true);
        }
        return myStar(false);
      }),
    );
  }
}
