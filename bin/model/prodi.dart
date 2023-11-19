class Prodi {

  final int? prodiID;
  final String? prodiNama;

  Prodi({
    this.prodiID,
    this.prodiNama
  });

  factory Prodi.fromJson(Map<String, dynamic> json) => Prodi(
    prodiID: int.parse(json['prodi_id']),
    prodiNama: json['prodi_nama']
  );

  Map<String, dynamic> toJson() => {
    "prodiID": prodiID,
    "prodiNama": prodiNama
  };

}