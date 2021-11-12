import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class FetchAllRepoInteractor extends FutureUseCase<dynamic, IResponse> {
  final GithubRepository _repository;

  FetchAllRepoInteractor(
    this._repository,
  );

  @override
  Future<IResponse> invoke(parameter) async {
    try {
      return _repository.getAll();
    } catch (e) {
      return ErrorResponse(error: e.toString());
    }
  }
}
