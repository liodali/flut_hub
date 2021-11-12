import 'package:flut_hub_core/flut_hub_core.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool initFetchIsDone = false;
  int maxPage = -1;
  int page = 1;
  IResponse? _reposResponse;
  final List<GithubRepo> _repoCached = [];
  final _githubReposPublisher = PublishSubject<List<GithubRepo>>();
  late Query _query;
  late Filter _filter;

  bool get isLoading => _isLoading;

  Filter get filter => _filter;

  IResponse? get githubReposResponse => _reposResponse;

  Stream<List<GithubRepo>> get stream => _githubReposPublisher.stream;

  HomeViewModel() {
    _query = Query(name: "");
    _query.addInner(name: "stars", value: ">100");
    _query.addInner(name: "language", value: "");
    _filter = Filter(
      query: _query,
      sort: SORT.stars,
      order: ORDER.desc,
    );
  }

  void setFilter(
    Query query, {
    SORT? sort,
    ORDER? order,
  }) {
    _filter = _filter.copyWith(
      query: query,
      sort: sort,
      order: order,
    );
    page = 1;
    notifyListeners();
  }

  Future<void> initGithubRepos() async {
    if (!initFetchIsDone) {
      await _fetchRepo(page);
      page++;
      initFetchIsDone = true;
    }
  }

  Future<void> getRepos({bool restart = false}) async {
    if (restart) {
      page = 1;
      maxPage = -1;
    }
    if ((page < maxPage && maxPage != -1) || !_isLoading) {
      _isLoading = true;
      notifyListeners();
      await _fetchRepo(page, refresh: restart);
      page++;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchRepo(
    int page, {
    int perPage = 30,
    bool refresh = false,
  }) async {
    final result = await getIt<SearchRepoByNameInteractor>().invoke({
      "query": _filter.toString(),
      "page": page,
      "per_page": perPage,
    });
    if (result is GithubReposResponse) {
      if (maxPage == -1) {
        maxPage = result.totalCount ?? -1;
      }
      if (refresh) {
        _repoCached.clear();
      }
      _repoCached.addAll(result.data);
      _githubReposPublisher.sink.add(_repoCached);
    } else {
      _githubReposPublisher.sink.addError((result as ErrorResponse).error);
    }
  }

  @override
  void dispose() {
    _githubReposPublisher.close();
    super.dispose();
  }
}
