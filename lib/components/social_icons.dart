import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons(
      {super.key,
      required this.color,
      required this.name,
      required this.iconSize,
      required this.icon,
      required this.size});

  final Size size;
  final IconData icon;
  final Color color;
  final String name;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(),
        ),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.05,
            ),
            Icon(
              icon,
              color: color,
              size: iconSize,
            ),
            SizedBox(
              width: size.width * 0.18,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
