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
    final backgroundColor = Theme.of(context).colorScheme.background;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        body: child,
      ),
    );
  }
}
