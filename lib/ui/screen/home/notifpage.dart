import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<_RecentOrderWidgetState>? _recentOrderWidgetKey;
  bool markAllAsReadClicked = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final colorScheme = Theme.of(context).colorScheme;

    return MaterialApp(
      routes: {
        '/notif': (context) => NotifPage(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notification',
            style: TextStyle(fontSize: 22),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              resetRecentOrderBackground(); 
              Navigator.pop(context);
            },
          ),
          backgroundColor: colorScheme.surface,
        ),
        body: Center(
          child: _buildPositionedTransactionBox(context, colorScheme),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildPositionedTransactionBox(
      BuildContext context, ColorScheme colorScheme) {
    _recentOrderWidgetKey ??= GlobalKey<_RecentOrderWidgetState>();

    return Stack(
      children: [
        Positioned(
          top: 10.0,
          left: 20.0,
          child: _buildTransactionBox(context, colorScheme),
        ),
        Positioned(
          top: 100.0,
          left: 20.0,
          child: _RecentOrderWidget(
            key: _recentOrderWidgetKey,
            colorScheme: colorScheme,
            markAllAsReadClicked: markAllAsReadClicked,
            onMarkAllAsRead: _handleMarkAllAsRead,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionBox(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: 130,
      height: 45,
      decoration: BoxDecoration(
        color: markAllAsReadClicked ? Colors.transparent : colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            _handleMarkAllAsRead();
          },
          child: Text(
            'Mark All As Read',
            style: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  void _handleMarkAllAsRead() {
    setState(() {
      markAllAsReadClicked = true;
      _recentOrderWidgetKey = GlobalKey<_RecentOrderWidgetState>();
    });
  }

  void resetRecentOrderBackground() {
    _recentOrderWidgetKey?.currentState?.resetBackground();
  }
}

class _RecentOrderWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final bool markAllAsReadClicked;
  final Function onMarkAllAsRead;

  const _RecentOrderWidget({
    Key? key,
    required this.colorScheme,
    required this.markAllAsReadClicked,
    required this.onMarkAllAsRead,
  }) : super(key: key);

  @override
  _RecentOrderWidgetState createState() => _RecentOrderWidgetState();
}

class _RecentOrderWidgetState extends State<_RecentOrderWidget> {
  bool isRecentOrderClicked = false;
  bool isPromoClicked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSingleIcon(context),
        SizedBox(height: 20.0),
        _buildpromo(context),
      ],
    );
  }

  Widget _buildSingleIcon(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isRecentOrderClicked && !widget.markAllAsReadClicked) {
          setState(() {
            isRecentOrderClicked = true;
          });
        }
      },
      onLongPress: () {
        setState(() {
          isRecentOrderClicked = false;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isRecentOrderClicked || widget.markAllAsReadClicked
              ? Colors.transparent
              : widget.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FractionalTranslation(
                translation: Offset(0.0, -1.0),
                child: Icon(
                  Icons.receipt_long,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(0, -1.0),
                  child: Text(
                    'Transaction',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: widget.colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Recent Order',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Your payment of Rp. 35.500,00 for your',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'recent order has been successfully',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'processed. Thank you for choosing',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Ambata Bakery!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildpromo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isPromoClicked && !widget.markAllAsReadClicked) {
          setState(() {
            isPromoClicked = true;
          });
        }
      },
      onLongPress: () {
        setState(() {
          isPromoClicked = false;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isPromoClicked || widget.markAllAsReadClicked
              ? Colors.transparent
              : widget.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FractionalTranslation(
                translation: Offset(0.0, -1.0),
                child: Icon(
                  Icons.percent,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(0, -1.0),
                  child: Text(
                    'Promo',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Weekend Discount',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Craving something sweet? Indulge guilt',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'free with a delightful 20% discount',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'on all our heavenly cakes this weekend',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'at Ambata Bakery!',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void resetBackground() {
    setState(() {
      isRecentOrderClicked = false;
      isPromoClicked = false;
    });
  }
}
