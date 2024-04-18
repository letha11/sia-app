import 'package:sia_app/utils/constants.dart';

class Environment {
  static String get rawEnv => appEnv;

  static bool get isProduction => rawEnv == "PROD";
  static bool get isDevelopment => rawEnv == "DEV";

  static String get baseUrl {
    if (isProduction) {
      return baseUrlProd;
    } else {
      return baseUrlDev;
    }
  }
}
