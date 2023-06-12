import 'package:flutter/material.dart';

class Kotak2 extends StatelessWidget {
  final String text1;
  final String? text2;

  const Kotak2({super.key, required this.text1, this.text2});

  get children => null;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10.0, right: 8),
        padding: EdgeInsets.only(right: 15, left: 15),
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 46, 46, 46),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              text2 ?? '',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
