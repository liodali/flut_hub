import 'package:json_annotation/json_annotation.dart';

import 'owner.dart';

part 'github_repo.g.dart';

@JsonSerializable()
class GithubRepo {
  final int id;
  final String name;
  @JsonKey(name: "full_name")
  final String fullName;
  final String? description;
  @JsonKey(name: "issues_url")
  final String issuesURL;
  final Owner owner;
  @JsonKey(name: "open_issues_count")
  final int? openIssues;
  @JsonKey(name: "stargazers_count")
  final int? stars;
  @JsonKey(name: "language")
  final String? language;

  factory GithubRepo.fromJson(Map<String, dynamic> json) => _$GithubRepoFromJson(json);

  Map toJson() => _$GithubRepoToJson(this);

  GithubRepo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.owner,
    required this.issuesURL,
    this.language,
    this.openIssues,
    this.stars,
  });
}
