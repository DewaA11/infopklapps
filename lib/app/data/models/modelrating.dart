import 'dart:convert';

Rating ratingFromJson(String str) => Rating.fromJson(json.decode(str));

String ratingToJson(Rating data) => json.encode(data.toJson());

class Rating {
  String id;
  double rating;
  DateTime timestamp;

  Rating({
    required this.id,
    required this.rating,
    required this.timestamp,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        rating: json["rating"].toDouble(),
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "timestamp": timestamp.toIso8601String(),
      };
}