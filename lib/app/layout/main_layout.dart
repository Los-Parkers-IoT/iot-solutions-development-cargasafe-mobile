import 'package:flutter/material.dart';
import 'main_drawer.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      body: SafeArea(child: child),
    );
  }
}
