enum HiveKey {
  accessToken,
  refreshToken,
}

extension HiveKeyX on HiveKey {
  String get valueAsString => toString().split('.').last;
}

// const String baseUrl = "http://127.0.0.1:5000/api";
const String baseUrl = "http://10.0.3.2:5000/api";
// const String baseUrl = "http://10.0.2.2:5000/api";
// const String baseUrl = "http://localhost:5000/api";

extension StringX on String{
  String capitalizeFirstCharacter() => this[0].toUpperCase() + substring(1);
}
