import 'dart:convert';

TempatModel tempatModelFromJson(String str) =>
    TempatModel.fromJson(json.decode(str));

String tempatModelToJson(TempatModel data) => json.encode(data.toJson());

class TempatModel {
  final String namaPt;
  final String namaterang;
  final String detailPt;
  final String ketentuanPt;
  final String jurusanPt;
  final String alamatPt;
  final String emailPt;
  final String syaratPt;
  final double ratingPt;
  final String fotoPt;
  final String fotouser;

  TempatModel({
    required this.namaPt,
    required this.namaterang,
    required this.detailPt,
    required this.ketentuanPt,
    required this.jurusanPt,
    required this.alamatPt,
    required this.emailPt,
    required this.syaratPt,
    required this.ratingPt,
    required this.fotoPt,
    required this.fotouser,
  });

  factory TempatModel.fromJson(Map<String, dynamic> json) => TempatModel(
        namaPt: json["nama_pt"] ?? "",
        namaterang: json["nama_terang"] ?? "",
        detailPt: json["detail_pt"] ?? "",
        ketentuanPt: json["ketentuan_pt"] ?? "",
        jurusanPt: json["jurusan_pt"] ?? "",
        alamatPt: json["alamat_pt"] ?? "",
        emailPt: json["email_pt"] ?? "",
        syaratPt: json["syarat_pt"] ?? "",
        ratingPt: json["rating_pt"] == 0 ? 0.0 : json["rating_pt"] ?? 0.0,
        fotoPt: json["foto_PT"] ?? "",
        fotouser: json["foto_user"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nama_pt": namaPt,
        "nama_terang": namaterang,
        "detail_pt": detailPt,
        "ketentuan_pt": ketentuanPt,
        "jurusan_pt": jurusanPt,
        "alamat_pt": alamatPt,
        "email_pt": emailPt,
        "syarat_pt": syaratPt,
        "rating_pt": ratingPt,
        "foto_PT": fotoPt,
        "foto_user": fotouser,
      };
}
