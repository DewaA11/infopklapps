import 'dart:convert';

MediaModel mediaModelFromJson(String str) =>
    MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  final String fotoUser;
  final String id;

  MediaModel({
    required this.fotoUser,
    required this.id,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        fotoUser: json["media"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "media": fotoUser,
        "id": id,
      };
}
