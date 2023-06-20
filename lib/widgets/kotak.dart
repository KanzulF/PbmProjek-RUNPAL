import 'package:flutter/material.dart';

class Kotak extends StatelessWidget {
  final String judul;
  final String text;
  final IconData icon;

  const Kotak(
      {super.key, required this.judul, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 16.0, right: 8),
        height: 50.0,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 46, 46, 46),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  judul,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color.fromARGB(255, 255, 18, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
