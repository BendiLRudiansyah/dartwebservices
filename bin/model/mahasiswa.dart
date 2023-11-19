import '../services/prodi_services.dart';
import 'prodi.dart';

class Mahasiswa {
   final int mhsID;
  final String mhsNpm;
  final String mhsNama;
  final String mhsJk;
  final Prodi prodi;
  final String mhsFoto1;
  final String mhsFoto2;

  Mahasiswa({
    required this.mhsID,
    required this.mhsNpm,
    required this.mhsNama,
    required this.mhsJk,
    required this.prodi,
    required this.mhsFoto1,
    required this.mhsFoto2
  });
factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
    mhsID: int.parse(json['mhs_id']),
    mhsNpm: json['mhs_npm'],
    mhsNama: json['mhs_nama'],
    mhsJk: json['mhs_jk'],
    prodi: json['prodi'] != Prodi() ? prodiFromJson(json['prodi']) : Prodi(),
    mhsFoto1: json['mhs_foto_1'],
    mhsFoto2: json['mhs_foto_2']
  );
Map<String, dynamic> toJson() => {
    "mhsID": mhsID,
    "mhsNpm": mhsNpm,
    "mhsNama": mhsNama,
    "mhsJk": mhsJk,
    "prodi": prodi.toJson(),
    "mhsFoto1": mhsFoto1,
    "mhsFoto2": mhsFoto2
  };


}

