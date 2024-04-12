enum HiveKey {
  accessToken,
  refreshToken,
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

// const String baseUrl = "http://127.0.0.1:5000/api";
const String baseUrl = "http://10.0.3.2:5000/api";
// const String baseUrl = "http://10.0.2.2:5000/api";
// const String baseUrl = "http://localhost:5000/api";

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
