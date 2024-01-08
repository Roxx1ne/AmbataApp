import 'package:ambataapp/ui/screen/checkout/payment.dart';
import 'package:ambataapp/ui/screen/checkout/promo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cart/cart_screen.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
          color: colorScheme.onSecondaryContainer,
        ),
        backgroundColor: colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.secondaryContainer,
                  ),
                  child: Icon(
                    Icons.location_on,
                    size: 32,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Address',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'JL. Merdeka Asri no. 1',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: colorScheme.outlineVariant,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/img/1recent.png',
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
                      'Strawberry Cheese Cake',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      '1 x Rp.25.000,00',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Flavour:',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Strawberry',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 96,
              width: 379,
              padding: EdgeInsets.only(top: 10, left: 10, right: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Same Day',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rp.15.000,00',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Divider(
              color: colorScheme.outlineVariant,
              thickness: 2,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promo',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: colorScheme.onBackground,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PromoPage()),
                    );
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: colorScheme.onBackground,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              color: colorScheme.outlineVariant,
              thickness: 2,
            ),
            const SizedBox(height: 10),
            Text(
              'Order Summary',
              style: GoogleFonts.poppins(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Rp. 25.000,00',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Rp. 10.000,00',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Fee',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Rp. 500,00',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              color: colorScheme.outlineVariant,
              thickness: 2,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Grand Total',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Rp. 35.500,00',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: colorScheme.outlineVariant,
              thickness: 2,
            ),
            const SizedBox(height: 5),
            Container(
              height: 40,
              width: 379,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: colorScheme.onSurfaceVariant,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentPage()),
                  );
                },
                child: Center(
                  child: Text(
                    'Choose Payment Method',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: colorScheme.onInverseSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
