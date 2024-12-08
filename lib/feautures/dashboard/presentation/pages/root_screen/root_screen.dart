import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:kitty/feautures/dashboard/presentation/widgets/bottom_navigation.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: const CustomButtomNavigationBar(),
    );
  }
}
