import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/bloc/home/home_bloc.dart';
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
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late final StreamSubscription<List<ConnectivityResult>> subscription;

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    subscription = Connectivity()
        // .onConnectivityChanged.skip(1)
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text(
              'Anda sedang offline, periksa koneksi anda untuk merasakan pengalaman yang lebih baik.',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatus()),
        ),
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) => Scaffold(
          body: FutureBuilder(
            future: sl.allReady(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BlocListener<AuthBloc, AuthState>(
                  listener: (_, state) {
                    if (state is AuthAuthenticated) {
                      _navigator.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<HomeBloc>(),
                            child: const HomePage(),
                          ),
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
        ),
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (_) => Container(
            color: Colors.white,
          ), // TODO: should be changed to splash screen / splash page
        ),
      ),
    );
  }
}
