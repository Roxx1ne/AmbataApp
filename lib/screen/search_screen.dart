import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
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
