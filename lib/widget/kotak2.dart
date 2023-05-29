import 'package:flutter/material.dart';

class Kotak2 extends StatelessWidget {
  final String judul;
  final String text;

  const Kotak2({super.key, required this.judul, required this.text});

  get children => null;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, right: 8),
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
              judul,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              text,
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
