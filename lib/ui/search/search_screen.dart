import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Selamat datang di Search Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
