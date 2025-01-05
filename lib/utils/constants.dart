/// possible values: "DEV", "PROD"
const String appEnv = String.fromEnvironment("APP_ENV", defaultValue: "DEV");
const String baseUrlDev = String.fromEnvironment("BASE_URL",
    defaultValue: "http://10.0.2.2:5000/api");
const String baseUrlProd = String.fromEnvironment("BASE_URL",
    defaultValue: "https://sia-mercu-scraping.vercel.app/api");

enum HiveKey {
  accessToken,
  refreshToken,
  detailJson,
  attendanceJson,
  scheduleJson,
  transcriptJson,
}

extension HiveKeyX on HiveKey {
  String get valueAsString => toString().split('.').last;
}

enum AttendanceStatus {
  present,
  absent,
  noClassYet,
}

extension AttendanceStatusX on AttendanceStatus {
  bool get isPresent => this == AttendanceStatus.present;
  bool get isAbsent => this == AttendanceStatus.absent;
  bool get isNoClassYet => this == AttendanceStatus.noClassYet;

  String get valueAsString {
    if (this == AttendanceStatus.present) {
      return "Hadir";
    } else if (this == AttendanceStatus.absent) {
      return "Tidak Hadir";
    } else {
      return "Belum Dilaksanakan";
    }
  }
}

extension StringX on String {
  String capitalizeFirstCharacter() => this[0].toUpperCase() + substring(1);

  AttendanceStatus toAttendanceStatus() {
    String val = toLowerCase();
    if (val == "hadir") {
      return AttendanceStatus.present;
    } else if (val == "tidak hadir") {
      return AttendanceStatus.absent;
    } else {
      return AttendanceStatus.noClassYet;
    }
  }
}
