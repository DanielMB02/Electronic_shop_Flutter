import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tienda_componentes/pages/home_page.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())),
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: Center(
          child: Text(
        "LOGGED IN AS: " + user.email!,
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
