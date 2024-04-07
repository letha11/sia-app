import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  UserDetail({
    required this.fakultas,
    required this.ipk,
    required this.ipsTerakhir,
    required this.jurusan,
    required this.kampus,
    required this.kelas,
    required this.kurikulum,
    required this.nama,
    required this.pendidikanAsal,
    required this.periodeMasuk,
    required this.semester,
    required this.sksTempuh,
    required this.status,
    required this.success,
  });

  late final String fakultas;
  late final String ipk;
  late final String ipsTerakhir;
  late final String jurusan;
  late final String kampus;
  late final String kelas;
  late final String kurikulum;
  late final String nama;
  late final String pendidikanAsal;
  late final String periodeMasuk;
  late final String semester;
  late final String sksTempuh;
  late final String status;
  late final bool success;

  UserDetail.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json['data'];
    success = json['success'];
    fakultas = data['fakultas'];
    ipk = data['ipk'];
    ipsTerakhir = data['ips_terakhir'];
    jurusan = data['jurusan'];
    kampus = data['kampus'];
    kelas = data['kelas'];
    kurikulum = data['kurikulum'];
    nama = data['nama'];
    pendidikanAsal = data['pendidikan_asal'];
    periodeMasuk = data['periode_masuk'];
    semester = data['semester'];
    sksTempuh = data['sks_tempuh'];
    status = data['status'];
  }

  Map<String, dynamic> toJson() {
    final dataJson = <String, dynamic>{};
    dataJson['success'] = success;
    dataJson['data'] = {};
    dataJson['data']['fakultas'] = fakultas;
    dataJson['data']['ipk'] = ipk;
    dataJson['data']['ips_terakhir'] = ipsTerakhir;
    dataJson['data']['jurusan'] = jurusan;
    dataJson['data']['kampus'] = kampus;
    dataJson['data']['kelas'] = kelas;
    dataJson['data']['kurikulum'] = kurikulum;
    dataJson['data']['nama'] = nama;
    dataJson['data']['pendidikan_asal'] = pendidikanAsal;
    dataJson['data']['periode_masuk'] = periodeMasuk;
    dataJson['data']['semester'] = semester;
    dataJson['data']['sks_tempuh'] = sksTempuh;
    dataJson['data']['status'] = status;
    return dataJson;
  }

  @override
  List<Object?> get props => [
        fakultas,
        ipk,
        ipsTerakhir,
        jurusan,
        kampus,
        kelas,
        kurikulum,
        nama,
        pendidikanAsal,
        periodeMasuk,
        semester,
        sksTempuh,
        status,
        success,
      ];
}