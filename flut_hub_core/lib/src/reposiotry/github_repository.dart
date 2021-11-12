import 'package:dio/dio.dart' as dio;
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../common/network_mixin.dart';
import '../common/utils.dart';

@LazySingleton(as: GithubRepository)
class GithubRepositoryImpl extends GithubRepository with NetworkMixin {
  @override
  Future<IResponse> getAll() async {
    final dio.Response<List> response = await get(
      endpoint: "repositories",
    );
    if (response.statusCode == 200) {
      return await compute(computeParserAllGithubRepoJson, response.data!);
    }
    return ErrorResponse(error: response.statusMessage);
  }

  @override
  Future<IResponse> searchForRepos({
    required String query,
    required int page,
    required int perPage,
  }) async {
    final dio.Response<Map<String, dynamic>> response = await get(
      endpoint: "search/repositories?$query&page=$page&per_page=$perPage",
    );
    if (response.statusCode == 200) {
      return await compute(computeParserSearchGithubJson, response.data!);
    }
    return ErrorResponse(error: response.statusMessage);
  }

  @override
  Future<IResponse> getIssuesRepo({
    required String query,
    required int page,
    required int perPage,
  }) async {
    final dio.Response<Map<String, dynamic>> response = await get(
      endpoint: "search/issues?$query&page=$page&per_page=$perPage",
    );
    if (response.statusCode == 200) {
      return await compute(computeParserSearchGithubIssueJson, response.data!);
    }
    return ErrorResponse(error: response.statusMessage);
  }
}
