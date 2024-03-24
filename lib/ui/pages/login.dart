import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Log In',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 44),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 2.0),
                            child: Icon(
                              Icons.person,
                              size: 24,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 38),
                          labelText: 'NIM',
                          hintText: '41522013123',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(right: 2.0),
                            child: Icon(
                              Icons.lock,
                              size: 24,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(minWidth: 38),
                          suffixIcon: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: _showPassword
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 24,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      size: 24,
                                    ),
                            ),
                          ),
                          labelText: 'Password',
                          hintText: '********',
                        ),
                      ),
                      const SizedBox(height: 67),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
