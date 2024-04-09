import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final bool success;
  final Map<String, List<ScheduleSubject>> mataKuliah;
  final List<Period> periode;

  const Schedule(
      {required this.success, required this.mataKuliah, required this.periode});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return Schedule(
      success: json['success'],
      mataKuliah: Map.from(data['mata_kuliah']).map(
        (k, v) => MapEntry<String, List<ScheduleSubject>>(
          k,
          List<ScheduleSubject>.from(
            v.map(
              (x) => ScheduleSubject.fromJson(x),
            ),
          ),
        ),
      ),
      periode: List<Period>.from(
        data['periode'].map(
          (x) => Period.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'mata_kuliah': mataKuliah
          .map((k, v) => MapEntry(k, v.map((x) => x.toJson()).toList())),
      'periode': periode.map((x) => x.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [success];
}

class ScheduleSubject extends Equatable {
  final String dosen;
  final String hari;
  final String namaMatkul;
  final String ruangan;
  final String time;

  const ScheduleSubject(
      {required this.dosen,
      required this.hari,
      required this.namaMatkul,
      required this.ruangan,
      required this.time});

  factory ScheduleSubject.fromJson(Map<String, dynamic> json) {
    return ScheduleSubject(
      dosen: json['dosen'],
      hari: json['hari'],
      namaMatkul: json['nama_matkul'],
      ruangan: json['ruangan'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dosen': dosen,
      'hari': hari,
      'nama_matkul': namaMatkul,
      'ruangan': ruangan,
      'time': time,
    };
  }

  @override
  List<Object?> get props => [dosen, hari, namaMatkul, ruangan, time];
}

class Period extends Equatable {
  final String label;
  final String value;

  const Period({required this.label, required this.value});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      label: json['label'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'value': value,
    };
  }

  @override
  List<Object?> get props => [label, value];
}
