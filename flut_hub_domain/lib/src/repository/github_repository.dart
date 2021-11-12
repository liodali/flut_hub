import 'package:flut_hub_domain/flut_hub_domain.dart';

abstract class GithubRepository extends Repository {
  Future<IResponse> searchForRepos({
    required String query,
    required int page,
    required int perPage,
  });

  Future<IResponse> getIssuesRepo({
    required String query,
    required int page,
    required int perPage,
  });
}
