import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                context.read<AuthBloc>().add(Logout());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 16),
                      Text("Logout"),
                    ],
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
