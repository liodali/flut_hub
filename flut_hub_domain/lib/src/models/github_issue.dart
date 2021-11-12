import 'package:json_annotation/json_annotation.dart';

import '../common/utils.dart';
import 'owner.dart';

part 'github_issue.g.dart';

@JsonSerializable()
class GithubIssue {
  final int id;
  final String title;
  final int number;
  @JsonKey(name: "body")
  final String description;
  final Owner user;
  @JsonKey(name: "created_at", fromJson: parseTo, toJson: formatTo)
  final DateTime createdAt;
  @JsonKey(name: "updated_at")
  final String updatedAt;
  final String state;
  @JsonKey(name: "comments")
  final int commentsCount;

  factory GithubIssue.fromJson(Map<String, dynamic> json) => _$GithubIssueFromJson(json);

  Map toJson() => _$GithubIssueToJson(this);

  GithubIssue({
    required this.id,
    required this.title,
    required this.number,
    required this.description,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.commentsCount,
  });
}
