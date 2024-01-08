import 'package:ambataapp/ui/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isDanaTapped = false;
  bool isGopayTapped = false;
  bool isOvoTapped = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: GoogleFonts.poppins(
            fontSize: 22,
          ),
        ),
        backgroundColor: colorScheme.surface,
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instant payment method:',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset(
                    'assets/img/dana.png',
                    height: 32,
                    width: 32,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Dana',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDanaTapped = !isDanaTapped;
                        isGopayTapped = false;
                        isOvoTapped = false;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: isDanaTapped
                          ? colorScheme.primary
                          : Colors.transparent,
                      radius: 16,
                      child: Icon(
                        Icons.radio_button_unchecked,
                        size: 20,
                        color:
                            isDanaTapped ? Colors.white : colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12), // Adjusted spacing between the rows
              //bag2
              Row(
                children: [
                  Image.asset(
                    'assets/img/gopay.png',
                    height: 32,
                    width: 32,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Gopay',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGopayTapped = !isGopayTapped;
                        isDanaTapped = false;
                        isOvoTapped = false;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: isGopayTapped
                          ? colorScheme.primary
                          : Colors.transparent,
                      radius: 16,
                      child: Icon(
                        Icons.radio_button_unchecked,
                        size: 20,
                        color:
                            isGopayTapped ? Colors.white : colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12), // Adjusted spacing between the rows
              //bag3
              Row(
                children: [
                  Image.asset(
                    'assets/img/ovo.png',
                    height: 32,
                    width: 32,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Ovo',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isOvoTapped = !isOvoTapped;
                        isDanaTapped = false;
                        isGopayTapped = false;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: isOvoTapped
                          ? colorScheme.primary
                          : Colors.transparent,
                      radius: 16,
                      child: Icon(
                        Icons.radio_button_unchecked,
                        size: 20,
                        color: isOvoTapped ? Colors.white : colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Text("Bank Transfer",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  )),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 32,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transfer',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Bill",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  )),
              SizedBox(height: 8),
              Text(
                'Rp. 35,500.00',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: GestureDetector(
            onTap: () {
              // Navigate to homepage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            child: Container(
              height: 40,
              width: 118.5,
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  'Pay ',
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
