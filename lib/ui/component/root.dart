import 'package:flutter/material.dart';

class AmbataScaffold extends StatelessWidget {
  const AmbataScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
  });

  final Widget child;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? false,
        body: child,
      ),
    );
  }
}
