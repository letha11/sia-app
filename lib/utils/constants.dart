enum HiveKey {
  accessToken,
  refreshToken,
  detailJson,
  attendanceJson,
  scheduleJson,
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

const String baseUrl = "https://sia-mercu-scraping.vercel.app/api";

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
