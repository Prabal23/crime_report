import 'package:json_annotation/json_annotation.dart';

part 'progress_json.g.dart';

@JsonSerializable()

class Progress{
  final int id;
  final String lat;
  final String longi;
  final String address;
  final String report_date;
  final String problem_id;
  final String situation;
  final String notes;

  Progress(this.id, this.lat, this.longi, this.address, this.report_date, this.problem_id, this.situation, this.notes);

  factory Progress.fromJson(Map<String, dynamic> json)
    => _$ProgressFromJson(json);
}