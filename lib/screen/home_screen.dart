import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signin_screen.dart';
import 'account_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Add pages here
  final List<Widget> _pages = [
    HomeContent(),
    SearchScreen(),
    AccountScreen(),
  ];

  final List<String> _titles = [
    'Freshly Baked',
    'Search Screen',
    'Account Screen'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
           onPressed: () {
              // Tambahkan logika untuk menangani aksi ketika ikon cart diklik
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart), 
            onPressed: () {
              // Tambahkan logika untuk menangani aksi ketika ikon cart diklik
            },
          ),
          IconButton(
            icon: Icon(
                Icons.logout),
             onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Selamat datang di Home Screen!',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
