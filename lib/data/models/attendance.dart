import 'package:equatable/equatable.dart';
import 'package:sia_app/utils/constants.dart';

class Attendance extends Equatable {
  List<Perkuliahan>? data;
  bool? success;

  Attendance({this.data, this.success});

  Attendance.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Perkuliahan>[];
      json['data'].forEach((v) {
        data!.add(Perkuliahan.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }

  @override
  List<Object?> get props => [
        data,
        success,
      ];
}

class Perkuliahan extends Equatable {
  String? namaMatkul;
  List<Kuliah>? perkuliahan;

  Perkuliahan({this.namaMatkul, this.perkuliahan});

  Perkuliahan.fromJson(Map<String, dynamic> json) {
    namaMatkul = json['nama_matkul'];
    if (json['perkuliahan'] != null) {
      perkuliahan = <Kuliah>[];
      json['perkuliahan'].forEach((v) {
        perkuliahan!.add(Kuliah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_matkul'] = namaMatkul;
    if (perkuliahan != null) {
      data['perkuliahan'] = perkuliahan!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        namaMatkul,
        perkuliahan,
      ];
}

class Kuliah extends Equatable {
  AttendanceStatus? kehadiran;
  String? linkModul;
  String? materi;
  int? pertemuan;
  DateTime? tanggal;

  Kuliah(
      {this.kehadiran,
      this.linkModul,
      this.materi,
      this.pertemuan,
      this.tanggal});

  Kuliah.fromJson(Map<String, dynamic> json) {
    kehadiran = (json['kehadiran'] as String).toAttendanceStatus();
    linkModul = json['link_modul'];
    materi = json['materi'];
    pertemuan = json['pertemuan'];
    tanggal = json['tanggal'] != null ? DateTime.parse(json['tanggal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kehadiran'] = kehadiran?.valueAsString ?? "";
    data['link_modul'] = linkModul;
    data['materi'] = materi;
    data['pertemuan'] = pertemuan;
    data['tanggal'] = tanggal?.toIso8601String();
    return data;
  }

  @override
  List<Object?> get props => [
        kehadiran,
        linkModul,
        materi,
        pertemuan,
        tanggal,
      ];
}
