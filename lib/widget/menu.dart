import 'package:flutter/material.dart';
import 'package:firstpro/screen/profil.dart';
import 'package:firstpro/screen/history.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      color: const Color.fromARGB(255, 46, 46, 46),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'profil',
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8.0),
                Text('Profil',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          const PopupMenuItem<String>(
            value: 'history',
            child: Row(
              children: [
                Icon(Icons.history),
                SizedBox(width: 8.0),
                Text('History',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
        // Aksi yang dilakukan saat menu dipilih
        if (value == 'profil') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const Profil(), // Ganti dengan layar tujuan untuk Menu 2
            ),
          );
        } else if (value == 'history') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const History(), // Ganti dengan layar tujuan untuk Menu 2
            ),
          );
        }
      },
    );
  }
}
