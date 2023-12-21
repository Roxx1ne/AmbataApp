import 'package:flutter/material.dart';

class Item {
  final String image;
  final String title;
  final String price;
  final String flavor;

  Item({
    required this.image,
    required this.title,
    required this.price,
    required this.flavor,
  });
}

class RecentTransactionPage extends StatelessWidget {
  final List<Item> items = [
    Item(
      image: 'assets/img/1recent.png',
      title: 'Strawberry Cheese Cake',
      price: 'Rp. 25.000,00',
      flavor: 'Strawberry',
    ),
    Item(
      image: 'assets/img/bread1.png', 
      title: 'Bread', 
      price: 'Rp. 10.000,00', 
      flavor: 'Original', 
    ),
    Item(
      image: 'assets/img/cake1.png', 
      title: 'Cake', 
      price: 'Rp. 25.000,00', 
      flavor: 'Chocolate ', 
    ),
    Item(
      image: 'assets/img/cookies1.png', 
      title: 'Cookies', 
      price: 'Rp. 10.000,00', 
      flavor: 'Chocolate Chips', 
    ),
    Item(
      image: 'assets/img/desert.png', 
      title: 'Desert', 
      price: 'Rp. 30.000,00', 
      flavor: 'Chocolate Cream Strawberry', 
    ),
    Item(
      image: 'assets/img/croissant1.png', 
      title: 'Croissant', 
      price: 'Rp. 15.000,00', 
      flavor: 'Green Tea', 
    ),
    Item(
      image: 'assets/img/donut.png', 
      title: 'Donut', 
      price: 'Rp. 10.000,00', 
      flavor: 'Strawberry', 
    ),
    Item(
      image: 'assets/img/kue_kacang.png', 
      title: 'Kue Kacang', 
      price: 'Rp. 5.000,00', 
      flavor: 'Peanut', 
    ),
    Item(
      image: 'assets/img/kue_ulang_tahun.png', 
      title: 'Kue Ulang Tahun', 
      price: 'Rp. 150.000,00', 
      flavor: 'Chocolate', 
    ),
    Item(
      image: 'assets/img/wedding_cake.png', 
      title: 'Wedding Cake', 
      price: 'Rp. 500.000,00', 
      flavor: 'Chocolate Vanilla Cream', 
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recent Transaction',
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: colorScheme.surface,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      item.image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.secondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.price,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Flavour:',
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.secondary,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          item.flavor,
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  'x1',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
