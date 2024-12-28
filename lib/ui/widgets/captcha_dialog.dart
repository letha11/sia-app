import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/auth/auth_bloc.dart';
import 'package:sia_app/ui/widgets/captcha_image.dart';

class CaptchaDialog extends StatefulWidget {
  final void Function() onSuccess;

  const CaptchaDialog({
    super.key,
    required this.onSuccess,
  });

  static Future<void> show({
    required BuildContext context,
    required void Function() onSuccess,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CaptchaDialog(
        onSuccess: onSuccess,
      ),
    );
  }

  @override
  State<CaptchaDialog> createState() => _CaptchaDialogState();
}

class _CaptchaDialogState extends State<CaptchaDialog> {
  final TextEditingController _captchaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthState initialAuthState = context.read<AuthBloc>().state;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (initialAuthState is! AuthSuccess && state is AuthSuccess) {
          Navigator.of(context).pop();
          widget.onSuccess();
        }

        if (initialAuthState is AuthSuccess) {
          initialAuthState = state;
        }
      },
      child: AlertDialog(
        title: Text(
          'Masukkan Captcha',
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => setState(() {}),
              child: SizedBox(
                width: double.infinity,
                child: CaptchaImage(),
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _captchaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Captcha tidak boleh kosong';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Captcha',
                      hintText: 'Masukkan Captcha',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          context.read<AuthBloc>().add(
                                ReLogin(
                                  captcha: _captchaController.text,
                                ),
                              );
                        },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _captchaController.dispose();
    super.dispose();
  }
}
