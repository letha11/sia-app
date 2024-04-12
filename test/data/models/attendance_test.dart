import 'package:flutter_test/flutter_test.dart';
import 'package:sia_app/data/models/attendance.dart';

void main() {
  const json = {
    "data": [
      {
        "nama_matkul": "ANALISA BERORIENTASI OBJEK (1A4153AB)",
        "perkuliahan": [
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/eDB5TXdBRE13RWpNMkFqUg==/",
            "materi":
                "• Mampu menyebutkan berbagai model proses rancang bangun perangkat lunak dan kapan berbagai model tersebut harus dipergunakan • Mampu menjelaskan model Unified Process • Mampu menyebutkan berbagai jenis diagram dalam UML dalam kaitannya dengan tahapan proses dalam Unified Process | Materi : • Perbandingan Berbagai Model Rancang Bangun Perangkat Lunak dan Siklus Hidup Perangkat Lunak serta Pendahuluan Unified Process dan UML",
            "pertemuan": 1,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/eTB5TXdBRE13RWpNMkFqUg==/",
            "materi":
                "• Mampu menjelaskan yang dimaksud dengan dokumen prasyarat perangkat lunak (business requirement) dan justifikasi perubahan yang terjadi dalam dokumen tersebut • Mampu menjelaskan konsep abstraksi, modularisasi dan enkapsulasi dikaitkan dengan perubahan dalam dokumen prasyarat perangkat lunak • Mampu menjelaskan konsep mengenai pendekatan terstruktur dalam membangun perangkat lunak • Mampu menjelaskan kelemahan-kelemahan pendekatan terstruktur • Mampu menjelaskan bagaimana pendekatan yang berorientasi objek dapat mengatasi kelemahan pendekatan terstruktur | Materi : • Perbandingan Pendekatan Terstruktur dan Pendekatan yang Berorientasi Objek",
            "pertemuan": 2,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/ejB5TXdBRE13RWpNMkFqUg==/",
            "materi":
                "• Mampu menjelaskan berbagai repositori informasi dalam sebuah organisasi • Mampu menjelaskan yang dimaksud dengan business critical factor • Mampu menjelaskan teknk-teknik pengumpulan data untuk menemukan business critical factor dan prasyarat perangkat lunak: wawancara, observasi, kuesioner, survey (ICAICT509A dan ICASAD502A) • Mampu menjelaskan bagian-bagian dari use case diagram • Mampu menjelaskan bagian-bagian dari use case description • Mampu membuat diagram use case dan use case description untuk mengkomunikasikan prasyarat perangkat lunak | Materi : • UML: Diagram Use Case dan Use Case Description",
            "pertemuan": 3,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/MDB5TXdBRE13RWpNMkFqUg==/",
            "materi":
                "• Mampu membedakan activity diagram dengan flowchart berdasarkan konsep swimlane, parallel activities serta junction dan guard. • Mampu membuat activity diagram untuk memodelkan proses bisnis organisasi berdasarkan identifikasi prasyarat perangkat lunak | Materi : • UML: Activity Diagram",
            "pertemuan": 4,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/MTB5TXdBRE13RWpNMkFqUg==/",
            "materi":
                "• Mampu menjelaskan definisi class, atribut, method, objek, inheritance dan polymorphism Mampu menjelaskan perbedaan rancangan perangkat lunak dengan pendekatan terstruktur dengan pendekatan yang berorientasi objek dalam beberapa contoh perangkat lunak. | Materi : • Definisi Class dan Objek serta Perbandingan Pendekatan Terstruktur dan Berorientasi Objek dalam Beberapa Contoh Sistem Informasi",
            "pertemuan": 5,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Belum Dilaksanakan",
            "link_modul":
                "https://modul.mercubuana.ac.id/modul.php?kd_mk=F062100003&namamk=ANALISA BERORIENTASI OBJEK&6",
            "materi":
                "• Mampu menjelaskan jenis-jenis class yang ditemukan dengan menggunakan analisis tekstual • Mampu menjelaskan proses menemukan class, berbagai atributnya serta hubungan di antara class, dengan analisis tekstual • Mampu membuat conceptual class diagram atau domain model untuk sebuah contoh sistem informasi (ICASAD502A) | Materi : • Menemukan class, atribut dan hubungan dengan pendekatan analisis tekstual untuk membangun conceptual class diagram atau domain model",
            "pertemuan": 6,
            "tanggal": null
          },
        ]
      },
      {
        "nama_matkul": "MOBILE PROGRAMMING (1A4153BC)",
        "perkuliahan": [
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/eDBpTnhBRE13RWpNMUV6Vg==/",
            "materi":
                "Memahami instalasi SDK dan pengaturan aplikasi | Materi : Instalasi Android SDK dan pengaturan aplikasi [Mednieks bab 1]",
            "pertemuan": 1,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/eTBpTnhBRE13RWpNMUV6Vg==/",
            "materi":
                "Memahami parameter dan karakter yang digunanan pada Java | Materi : Parameter pada pemrograman Java [Mednieks bab 2]",
            "pertemuan": 2,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/ejBpTnhBRE13RWpNMUV6Vg==/",
            "materi":
                "Memahami pembuatan dan penggunaan obyek dan metode pada Java | Materi : Obyek dan Metode pada pemrograman Java [Mednieks bab 2]",
            "pertemuan": 3,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/MDBpTnhBRE13RWpNMUV6Vg==/",
            "materi":
                "Memahami penggunaan lingkungan Runtime Android pada Java | Materi : Lingkungan Runtime pada Android [Mednieks bab 3]",
            "pertemuan": 4,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Hadir",
            "link_modul":
                "http://modul.mercubuana.ac.id/MTBpTnhBRE13RWpNMUV6Vg==/",
            "materi":
                "Memahami penggunaan aplikasi Signing Android | Materi : Aplikasi Signing pada Android [Mednieks bab 4]",
            "pertemuan": 5,
            "tanggal": "2024-03-06T00:00:00.000"
          },
          {
            "kehadiran": "Belum Dilaksanakan",
            "link_modul":
                "https://modul.mercubuana.ac.id/modul.php?kd_mk=W152100016&namamk=MOBILE PROGRAMMING&6",
            "materi":
                "Memahami pengaturan API Android | Materi : Pengaturan API untuk Aplikasi [Mednieks bab 4]",
            "pertemuan": 6,
            "tanggal": null
          },
        ]
      },
    ],
    "success": true,
  };

  // late Attendance attendance;
  //
  // setUp(() {});

  group('constructor', () {
    test('formJson', () {
      expect(
        Attendance.fromJson(json),
        isA<Attendance>().having((p0) => p0.success, 'success status', true),
      );
    });

    test('work', () {
      expect(
        Attendance(
          data: [
            Perkuliahan(
              namaMatkul: "Bahasa Indonesia",
              perkuliahan: [Kuliah()],
            ),
          ],
          success: true,
        ),
        isA<Attendance>().having((p0) => p0.success, "success status", true),
      );
    });
  });

  test('toJson method', () {
    expect(Attendance.fromJson(json).toJson(), json);
  });
}
