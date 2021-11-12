import 'package:flut_hub_core/flut_hub_core.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  configureInjection();

  test('test search_repo', () async {
    final useCaseSearch = getIt<SearchRepoByNameInteractor>();

    final GithubReposResponse response =
        await useCaseSearch.invoke({"q": "q=osm+language:dart", "page": 3}) as GithubReposResponse;
    expect(response.totalCount, 37);
    expect(response.data.isEmpty, true);
  });
}
