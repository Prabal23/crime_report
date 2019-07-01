// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(json['id'] as int, json['photo'] as String);
}

Map<String, dynamic> _$PhotoToJson(Photo instance) =>
    <String, dynamic>{'id': instance.id, 'photo': instance.photo};
