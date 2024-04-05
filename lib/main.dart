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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatus()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) => FutureBuilder(
          future: sl.allReady(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocListener<AuthBloc, AuthState>(
                listener: (_, state) {
                  if (state is AuthAuthenticated) {
                    _navigator.pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                      (_) => false,
                    );
                  } else if (state is AuthUnauthenticated) {
                    _navigator.pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                      (_) => false,
                    );
                  }
                },
                child: child!,
              );
            }

            return child!;
          },
        ),
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Container(
              color: Colors
                  .white), // TODO: should be changed to splash screen / splash page
        ),
      ),
    );
  }
}
