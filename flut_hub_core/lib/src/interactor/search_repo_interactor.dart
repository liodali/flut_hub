import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:injectable/injectable.dart';
/// SearchRepoByNameInteractor
/// this class responsible to get  repositories by name and other fitters specified by the user using api /search/repositories?q=
/// it's accept a type parameter  of GithubRepository, with help of the package injectable we inject the right type
/// it has invoke method that will call method searchForRepos from repository instance
/// and return IResponse object can be GithubRepoResponse or ErrorResponse if anything happen

@Injectable()
class SearchRepoByNameInteractor extends FutureUseCase<dynamic, IResponse> {
  final GithubRepository _repository;

  SearchRepoByNameInteractor(
    this._repository,
  );

  @override
  Future<IResponse> invoke(parameter) async {
    try {
      return _repository.searchForRepos(
        query: parameter["query"],
        page: parameter["page"],
        perPage: parameter["per_page"] ?? 30,
      );
    } catch (e) {
      return ErrorResponse(error: e.toString());
    }
  }
}
