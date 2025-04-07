import 'package:flutter/material.dart';

class DisplayTotalPrice extends StatefulWidget {
  const DisplayTotalPrice({super.key});

  @override
  State<DisplayTotalPrice> createState() => _DisplayTotalPriceState();
}

class _DisplayTotalPriceState extends State<DisplayTotalPrice> {
  bool isSwicth = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.black38),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Display total price',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Includes all fees, before taxes',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14.5,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10.0,
            ),
            Switch(
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey,
              value: isSwicth,
              onChanged: (value) {
                setState(() {
                  isSwicth = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
