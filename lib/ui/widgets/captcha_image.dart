import 'package:flutter/material.dart';
import 'package:sia_app/core/environment.dart';
import 'package:sia_app/core/service_locator.dart';
import 'package:sia_app/data/repository/local/local_db_repository.dart';
import 'package:sia_app/utils/constants.dart';

class CaptchaImage extends StatelessWidget {
  CaptchaImage({super.key});

  final _localDB = sl<LocalDBRepository>();

  Map<String, String> _getHeaders() {
    final Map<String, String> temp = {};

    if (_localDB.get(HiveKey.accessToken) != null) {
      temp['Authorization'] = 'Bearer ${_localDB.get(HiveKey.accessToken)}';
    }

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "${Environment.baseUrl}/captcha?b=${DateTime.now().millisecondsSinceEpoch}",
      headers: _getHeaders(),
      fit: BoxFit.cover,
    );
  }
}
