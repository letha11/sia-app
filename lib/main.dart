import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/core/service_locator.dart';
import 'package:sia_app/theme.dart';
import 'package:sia_app/ui/pages/home.dart';
import 'package:sia_app/ui/pages/login.dart';

void main() async {
  await Hive.initFlutter();

  initialize(); // getit

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        home: FutureBuilder(
          future: sl.allReady(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocListener<AuthBloc, AuthState>(
                listener: (_, state) {
                  if (state is AuthAuthenticated) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  } else if (state is AuthUnauthenticated) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  }
                },
                child: Container(color: Colors.white),
              );
            }

            return Container(color: Colors.white);
          },
        ),
      ),
    );
  }
}
