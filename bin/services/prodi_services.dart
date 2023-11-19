import 'dart:convert';

import '../model/model.dart';

Prodi prodiFromJson(String str) => Prodi.fromJson(json.decode(str));
String prodiToJson(Prodi data) => json.encode(data.toJson());
List<Prodi> prodisFromJson(String str) => List<Prodi>.from(json.decode(str).map((x) => Prodi.fromJson(x)));
String prodisToJson(List<Prodi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));