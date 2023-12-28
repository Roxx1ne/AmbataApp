import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'recent_transaction.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Account',
              style: TextStyle(fontSize: 22),
            ),
            Spacer(), 
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.surface,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              
              exit(0);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 480,
            left: 10,
            right: 10,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.account_circle,
                          color: colorScheme.onSurface,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'John Doe',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Member',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Icon(Icons.link, size: 24),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 430,
            left: 10,
            child: InkWell(
              onTap: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecentTransactionPage()),
                );
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.receipt_long, size: 30),
                  SizedBox(width: 10),
                  Text(
                    'Recent Transaction',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
