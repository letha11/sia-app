import 'package:flutter_test/flutter_test.dart';
import 'package:sia_app/data/models/user_detail.dart';

void main() {
  String fakultas = "Ilmu Komputer";
  String ipk = "3.86";
  String ipsTerakhir = "3.87"; // Using camelCase for consistency
  String jurusan = "Teknik Informatika";
  String kampus = "Meruya";
  String kelas = "Reguler";
  String kurikulum = "1521 - Kurikulum 2021 Reguler";
  String nama = "IBKA ANHAR FATCHA(Lapor BAP, ijazah)";
  String nim = "41522010137";
  String pendidikanAsal = "SMU";
  String periodeMasuk = "Semester Gasal 2022";
  String semester = "4";
  String sksTempuh = "66";
  String status = "Aktif";
  bool success = true;

  late Map<String, dynamic> json;

  setUp(() {
    json = {
      "data": {
        "fakultas": fakultas,
        "ipk": ipk,
        "ips_terakhir": ipsTerakhir,
        "jurusan": jurusan,
        "kampus": kampus,
        "kelas": kelas,
        "kurikulum": kurikulum,
        "nama": nama,
        "pendidikan_asal": pendidikanAsal,
        "periode_masuk": periodeMasuk,
        "semester": semester,
        "sks_tempuh": sksTempuh,
        "status": status,
      },
      "success": true,
    };
  });

  group('constructor', () {
    test('default work', () {
      expect(
        UserDetail(
            fakultas: fakultas,
            ipk: ipk,
            ipsTerakhir: ipsTerakhir,
            jurusan: jurusan,
            kampus: kampus,
            kelas: kelas,
            kurikulum: kurikulum,
            nama: nama,
          nim: nim,
            pendidikanAsal: pendidikanAsal,
            periodeMasuk: periodeMasuk,
            semester: semester,
            sksTempuh: sksTempuh,
            status: status,
            success: success),
        isA<UserDetail>()
            .having((p0) => p0.fakultas, "fakultas", fakultas)
            .having((p0) => p0.ipk, "ipk", ipk)
            .having((p0) => p0.ipsTerakhir, "ipsTerakhir", ipsTerakhir)
            .having((p0) => p0.jurusan, "jurusan", jurusan)
            .having((p0) => p0.kampus, "kampus", kampus)
            .having((p0) => p0.kelas, "kelas", kelas)
            .having((p0) => p0.kurikulum, "kurikulum", kurikulum)
            .having((p0) => p0.nama, "nama", nama)
            .having((p0) => p0.pendidikanAsal, "pendidikanAsal", pendidikanAsal)
            .having((p0) => p0.periodeMasuk, "periodeMasuk", periodeMasuk)
            .having((p0) => p0.semester, "semester", semester)
            .having((p0) => p0.sksTempuh, "sksTempuh", sksTempuh)
            .having((p0) => p0.status, "status", status),
      );
    });

    test('fromJson', () {
      expect(UserDetail.fromJson(json), isA<UserDetail>());
    });
  });

  group('toJson method', () {
    test('work', () {
      final userDetail = UserDetail(
          fakultas: fakultas,
          ipk: ipk,
          ipsTerakhir: ipsTerakhir,
          jurusan: jurusan,
          kampus: kampus,
          kelas: kelas,
          kurikulum: kurikulum,
          nama: nama,
          nim: nim,
          pendidikanAsal: pendidikanAsal,
          periodeMasuk: periodeMasuk,
          semester: semester,
          sksTempuh: sksTempuh,
          status: status,
          success: success);

      expect(userDetail.toJson(), equals(json));
    });
  });
}
