import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SearchIssueRepoInteractor extends FutureUseCase<dynamic, IResponse> {
  final GithubRepository _repository;

  SearchIssueRepoInteractor(
    this._repository,
  );

  @override
  Future<IResponse> invoke(parameter) async {
    try {
      return _repository.getIssuesRepo(
        query: parameter["query"],
        page: parameter["page"],
        perPage: parameter["per_page"] ?? 30,
      );
    } catch (e) {
      return ErrorResponse(error: e.toString());
    }
  }
}
