import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/ui/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                _isLoading = state is AuthLoading;
                return Column(
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
                            enabled: !_isLoading,
                            controller: _usernameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Username tidak boleh kosong";
                              }
                              return null;
                            },
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 2.0),
                                child: Icon(
                                  Icons.person,
                                  color: _isLoading ? Theme.of(context).colorScheme.onSurface.withOpacity(0.35) : null,
                                  size: 24,
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(minWidth: 38),
                              labelText: 'NIM',
                              hintText: '41522013123',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            enabled: !_isLoading,
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Password tidak boleh kosong";
                              }
                              return null;
                            },
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 2.0),
                                child: Icon(
                                  Icons.lock,
                                  color: _isLoading ? Theme.of(context).colorScheme.onSurface.withOpacity(0.35) : null,
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
                                      ? Icon(
                                          Icons.visibility,
                                          color: Theme.of(context).colorScheme.onSurface,
                                          size: 24,
                                        )
                                      : Icon(
                                          Icons.visibility_off,
                                          color: Theme.of(context).colorScheme.onSurface,
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
                              onPressed: state is! AuthLoading
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                              Login(
                                                username: _usernameController.text,
                                                password: _passwordController.text,
                                              ),
                                            );
                                      }
                                    }
                                  : null,
                              child: state is! AuthLoading
                                  ? const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
