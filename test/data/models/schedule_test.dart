import 'package:flutter_test/flutter_test.dart';
import 'package:sia_app/data/models/schedule.dart';

void main() {
  const json = {
    "data": {
      "mata_kuliah": {
        "jumat": [
          {
            "dosen": "Syamsir Alam, S.Kom, MT",
            "hari": "Jumat",
            "nama_matkul":
                "PENDIDIKAN ANTI KORUPSI DAN ETIK UMB Anti-Corruption Education and UMB Ethics",
            "ruangan": "B-402",
            "time": "07:30 - 09:10"
          },
          {
            "dosen": "Dadi Waras Suhardjono, Dr. S.S, M.Pd.",
            "hari": "Jumat",
            "nama_matkul": "BAHASA INDONESIA Indonesian Language",
            "ruangan": "E-403",
            "time": "09:30 - 11:10"
          }
        ],
        "kamis": [
          {
            "dosen": "Rudi Hartono, ST, M.Kom",
            "hari": "Kamis",
            "nama_matkul":
                "PENGOLAHAN CITRA Image Processing https://fast.mercubuana.ac.id",
            "ruangan": "VT.D-101",
            "time": "07:30 - 10:00"
          },
          {
            "dosen": "Dwi Ade Handayani Capah, S.Kom, M.Kom",
            "hari": "Kamis",
            "nama_matkul":
                "PEMODELAN 2D/3D Modeling 2D/3D https://fast.mercubuana.ac.id",
            "ruangan": "VE-048",
            "time": "10:15 - 12:45"
          },
          {
            "dosen": "Sustono, Ir, MT",
            "hari": "Kamis",
            "nama_matkul": "KOMPUTASI AWAN Cloud Computing",
            "ruangan": "B-302",
            "time": "13:15 - 15:45"
          }
        ],
        "rabu": [
          {
            "dosen": "Siti Maesaroh, S.Kom., M.T.I",
            "hari": "Rabu",
            "nama_matkul":
                "ANALISA BERORIENTASI OBJEK Object Oriented Analysis",
            "ruangan": "D-308",
            "time": "07:30 - 10:00"
          },
          {
            "dosen": "Hariesa Budi Prabowo, ST., MM",
            "hari": "Rabu",
            "nama_matkul": "MOBILE PROGRAMMING Mobile Programming",
            "ruangan": "T-007",
            "time": "10:15 - 12:45"
          }
        ],
        "senin": [
          {
            "dosen": "Yayah Makiyah, SS,M.Pd",
            "hari": "Senin",
            "nama_matkul": "ENGLISH FOR COMPUTER I English for Computer I",
            "ruangan": "A-406",
            "time": "13:15 - 15:45"
          }
        ]
      },
      "periode": [
        {"label": "Gasal 2022", "value": "20221"},
        {"label": "Genap 2022", "value": "20223"},
        {"label": "Gasal 2023", "value": "20231"},
        {"label": "Genap 2023", "value": "20233"}
      ]
    },
    "success": true
  };

  late Schedule jadwal;

  setUp(() {
    jadwal = const Schedule(
      success: true,
      periode: [
        Period(label: 'Gasal 2022', value: "20221"),
      ],
      mataKuliah: {
        "senin": [
          ScheduleSubject(
            dosen: "Wawan Gunawan",
            hari: "Senin",
            namaMatkul: "Pemrograman Lanjut",
            ruangan: "A-402",
            time: "07.30-12.00",
          ),
        ],
      },
    );
  });

  group('constructor', () {
    test('work', () {
      expect(jadwal, isA<Schedule>());
    });

    test('fromJson works', () {
      expect(
        Schedule.fromJson(json),
        isA<Schedule>().having((p0) => p0.success, "success", true),
      );
    });
  });

  test('toJson method work', () {
    expect(jadwal.toJson(), isA<Map<String, dynamic>>());
  });
}
