
import 'package:flutter/material.dart';

class DashboardViewPage extends StatelessWidget {
  const DashboardViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome to DashboardViewPage'),
      ),
    );
  }
}