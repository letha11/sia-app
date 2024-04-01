enum HiveKey {
  accessToken,
}

extension HiveKeyX on HiveKey {
  String get valueAsString => toString().split('.').last;
}

const String baseUrl = "http://127.0.0.1:5000/api";
