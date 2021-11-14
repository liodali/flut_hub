import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:injectable/injectable.dart';
/// SearchIssueRepoInteractor
/// this class responsible to get all opened issued of the sepecific repo  using api /search/issues?q=repo:
/// it's accept a type parameter  of GithubRepository, with help of the package injectable we inject the right type
/// it has invoke method that will call method getIssuesRepo from repository instance
/// and return IResponse object can be GithubIssueResponse or ErrorResponse if anything wrong happen
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
