import 'package:json_annotation/json_annotation.dart';

part 'problem.g.dart';

@JsonSerializable()

class Problem{
  final int id;
  final String title;

  Problem(this.id, this.title);

  factory Problem.fromJson(Map<String, dynamic> json)
    => _$ProblemFromJson(json);
}