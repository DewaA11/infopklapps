import 'dart:convert';

MediavideoModel mediavideoModelFromJson(String str) =>
    MediavideoModel.fromJson(json.decode(str));

String mediavideoModelToJson(MediavideoModel data) =>
    json.encode(data.toJson());

class MediavideoModel {
  final String video;
  final String id;

  MediavideoModel({
    required this.video,
    required this.id,
  });

  factory MediavideoModel.fromJson(Map<String, dynamic> json) =>
      MediavideoModel(
        video: json["mediavideo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "mediavideo": video,
        "id": id,
      };
}
