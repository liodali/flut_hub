import 'package:flut_hub_domain/flut_hub_domain.dart';

Future<IResponse> computeParserSearchGithubJson(Map<String, dynamic> input) async {
  return GithubReposResponse(
    totalCount: input.containsKey("total_count") ? input["total_count"] : -1,
    repos: (input["items"] as List).map((e) => GithubRepo.fromJson(e)).toList(),
  );
}
Future<IResponse> computeParserSearchGithubIssueJson(Map<String, dynamic> input) async {
  return GithubIssuesResponse(
    totalCount: input.containsKey("total_count") ? input["total_count"] : -1,
    issues: (input["items"] as List).map((e) => GithubIssue.fromJson(e)).toList(),
  );
}

Future<IResponse> computeParserAllGithubRepoJson(List<dynamic> input) async {
  return GithubReposResponse(
    totalCount: -1,
    repos: (List.castFrom<dynamic, Map<String, dynamic>>(input))
        .map((e) => GithubRepo.fromJson(e))
        .toList(),
  );
}
