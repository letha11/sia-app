import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Container(),
    );
  }
}
