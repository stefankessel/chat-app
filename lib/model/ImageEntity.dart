// To parse this JSON data, do
//
//     final imageEntity = imageEntityFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ImageEntity imageEntityFromJson(String str) =>
    ImageEntity.fromJson(json.decode(str));

String imageEntityToJson(ImageEntity data) => json.encode(data.toJson());

class ImageEntity {
  ImageEntity({
    required this.id,
    required this.filename,
    required this.urlFullSize,
    required this.urlMediumSize,
    required this.urlSmallSize,
  });

  final String id;
  final String filename;
  final String urlFullSize;
  final String urlMediumSize;
  final String urlSmallSize;

  factory ImageEntity.fromJson(Map<String, dynamic> json) => ImageEntity(
        id: json["id"],
        filename: json["filename"],
        urlFullSize: json["url_full_size"],
        urlMediumSize: json["url_medium_size"],
        urlSmallSize: json["url_small_size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "url_full_size": urlFullSize,
        "url_medium_size": urlMediumSize,
        "url_small_size": urlSmallSize,
      };
}
