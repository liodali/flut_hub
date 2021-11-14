import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:injectable/injectable.dart';

/// FetchAllRepoInteractor
/// this class responsible to get all repositories using api /repositories
/// it's accept a type parameter  of GithubRepository, with help of the package injectable we inject the right type
/// it has invoke method that will call method getAll from repository instance
/// and return IResponse object can be GithubRepoResponse or ErrorResponse if anything happen
@Injectable()
class FetchAllRepoInteractor extends FutureUseCase0<IResponse> {
  final GithubRepository _repository;

  FetchAllRepoInteractor(
    this._repository,
  );

  @override
  Future<IResponse> invoke() async {
    try {
      return _repository.getAll();
    } catch (e) {
      return ErrorResponse(error: e.toString());
    }
  }
}
