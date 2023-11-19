import 'dart:convert';

import '../model/model.dart';

Mahasiswa mahasiswaFromJson(String str) => Mahasiswa.fromJson(json.decode(str));
String mahasiswaToJson(Mahasiswa data) => json.encode(data.toJson());
List<Mahasiswa> mahasiswasFromJson(String str) => List<Mahasiswa>.from(json.decode(str).map((x) => Mahasiswa.fromJson(x)));
String mahasiswasToJson(List<Mahasiswa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));