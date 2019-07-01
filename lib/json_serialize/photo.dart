import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()

class Photo{
  final int id;
  final String photo;

  Photo(this.id, this.photo);

  factory Photo.fromJson(Map<String, dynamic> json)
    => _$PhotoFromJson(json);
}