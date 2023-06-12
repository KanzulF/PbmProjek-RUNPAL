// import 'package:firstpro/controllers/user.dart';
// import 'package:flutter/material.dart';
// import 'package:firstpro/widgets/kotak2.dart';
// import 'package:firstpro/models/user.dart';
// import 'dart:convert';

// class Profil extends StatefulWidget {
//   Profil({Key? key}) : super(key: key);

//   @override
//   _ProfilState createState() => _ProfilState();
// }

// class _ProfilState extends State<Profil> {
//   UserRepository repository = UserRepository();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController levelController = TextEditingController();
//   TextEditingController distanceController = TextEditingController();
//   TextEditingController goalsController = TextEditingController();

//   @override
//   saveData() async {
//     if (user != null) {
//       User updatedUser = User(
//         id: user!.id,
//         name: nameController.text,
//         // age: int.tryParse(ageController.text) ?? 0,
//         // gender: genderController.text,
//       );
//       try {
//         await repository.updateUser(updatedUser);
//         setState(() {
//           user = updatedUser;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('User data updated successfully')),
//         );
//       } catch (e) {
//         print(e);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update user data')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         centerTitle: true,
//         title: Image.asset('assets/icons/runpal.png', height: 50),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: saveData,
//           ),
//         ],
//       ),
//       body: user != null
//           ? Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 20),
//                     const Text(
//                       'Profil',
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                     ),
//                     SizedBox(height: 20),
//                     const Text(
//                       'Name',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     Row(
//                       children: [
//                         TextField(
//                           controller: nameController,
//                           decoration: InputDecoration(labelText: 'Name'),
//                         ),
//                         // Kotak2(
//                         //   text1: '${user!.name}',
//                         // ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     const Text(
//                       'Age',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     Row(
//                       children: [
//                         TextField(
//                           controller: ageController,
//                           decoration: InputDecoration(labelText: 'Age'),
//                           keyboardType: TextInputType.number,
//                         ),
//                         // Kotak2(
//                         //   text1: '${user!.age}',
//                         // ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     const Text(
//                       'Gender',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     Row(
//                       children: [
//                         TextField(
//                           controller: genderController,
//                           decoration: InputDecoration(labelText: 'Gender'),
//                         ),
//                         // Kotak2(
//                         //   text1: '${user!.gender}',
//                         // ),
//                       ],
//                     ),
//                   ]))
//           : Center(
//               child: Text(
//                 'asdas',
//                 style: TextStyle(fontSize: 18, color: Colors.white),
//               ),
//             ),
//     );
//   }
// }


