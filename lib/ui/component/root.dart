import 'package:flutter/material.dart';

class AmbataScaffold extends StatelessWidget {
  const AmbataScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
  });

  final Widget child;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        body: child,
      ),
    );
  }
}
