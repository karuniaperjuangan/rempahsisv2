// To parse this JSON data, do
//
//     final rempah = rempahFromJson(jsonString);

import 'dart:convert';

List<Rempah> rempahFromJson(String str) => List<Rempah>.from(json.decode(str).map((x) => Rempah.fromJson(x)));

String rempahToJson(List<Rempah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rempah {
    int id;
    String namaRempah;
    String namaIlmiah;
    String gambar;
    String ikhtisar;
    String morfologi;
    String ciri;
    String khasiat;
    String kegunaan;
    String potensi;
    String referensiMorfologi;
    String referensiCiri;
    String referensiKhasiat;
    String referensiKegunaan;
    String referensiPotensi;

    Rempah({
        required this.id,
        required this.namaRempah,
        required this.namaIlmiah,
        required this.gambar,
        required this.ikhtisar,
        required this.morfologi,
        required this.ciri,
        required this.khasiat,
        required this.kegunaan,
        required this.potensi,
        required this.referensiMorfologi,
        required this.referensiCiri,
        required this.referensiKhasiat,
        required this.referensiKegunaan,
        required this.referensiPotensi,
    });

    factory Rempah.fromJson(Map<String, dynamic> json) => Rempah(
        id: json["id"],
        namaRempah: json["nama_rempah"],
        namaIlmiah: json["nama_ilmiah"],
        gambar: json["gambar"],
        ikhtisar: json["ikhtisar"],
        morfologi: json["morfologi"],
        ciri: json["ciri"],
        khasiat: json["khasiat"],
        kegunaan: json["kegunaan"],
        potensi: json["potensi"],
        referensiMorfologi: json["referensi_morfologi"],
        referensiCiri: json["referensi_ciri"],
        referensiKhasiat: json["referensi_khasiat"],
        referensiKegunaan: json["referensi_kegunaan"],
        referensiPotensi: json["referensi_potensi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama_rempah": namaRempah,
        "nama_ilmiah": namaIlmiah,
        "gambar": gambar,
        "ikhtisar": ikhtisar,
        "morfologi": morfologi,
        "ciri": ciri,
        "khasiat": khasiat,
        "kegunaan": kegunaan,
        "potensi": potensi,
        "referensi_morfologi": referensiMorfologi,
        "referensi_ciri": referensiCiri,
        "referensi_khasiat": referensiKhasiat,
        "referensi_kegunaan": referensiKegunaan,
        "referensi_potensi": referensiPotensi,
    };
}
