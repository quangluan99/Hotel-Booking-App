import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 125.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Country/Regin",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "VietNam(+84)",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              
              decoration: InputDecoration(
                
                border: InputBorder.none,
                hintText: 'Phone number',
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.black45),
              ),
            ),
          )
        ],
      ),
    );
  }
}
