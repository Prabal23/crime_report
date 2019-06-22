// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Progress _$ProgressFromJson(Map<String, dynamic> json) {
  return Progress(
      json['id'] as int,
      json['lat'] as String,
      json['longi'] as String,
      json['address'] as String,
      json['report_date'] as String,
      json['problem_id'] as String,
      json['situation'] as String,
      json['notes'] as String);
}

Map<String, dynamic> _$ProgressToJson(Progress instance) => <String, dynamic>{
      'id': instance.id,
      'lat': instance.lat,
      'longi': instance.longi,
      'address': instance.address,
      'report_date': instance.report_date,
      'problem_id': instance.problem_id,
      'situation': instance.situation,
      'notes': instance.notes
    };
