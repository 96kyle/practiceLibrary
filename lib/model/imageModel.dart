import 'package:json_annotation/json_annotation.dart';

part 'imageModel.g.dart';

@JsonSerializable()
class ImageModel {
  final int id;
  final String title;
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
