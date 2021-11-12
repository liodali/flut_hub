import 'package:flut_hub_domain/flut_hub_domain.dart';

abstract class IResponse {}

class ErrorResponse extends IResponse {
  dynamic error;

  ErrorResponse({
    required this.error,
  });
}

class Response<T> extends IResponse {
  T data;

  Response({
    required this.data,
  });
}

class GithubReposResponse extends Response<List<GithubRepo>> {
  int? totalCount;

  GithubReposResponse({
    required List<GithubRepo> repos,
    this.totalCount,
  }) : super(data: repos);
}
class GithubIssuesResponse extends Response<List<GithubIssue>> {
  int? totalCount;

  GithubIssuesResponse({
    required List<GithubIssue> issues,
    this.totalCount,
  }) : super(data: issues);
}
