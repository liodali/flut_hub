import 'package:flut_hub_core/flut_hub_core.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class IssueRepoViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool initFetchIsDone = false;
  int maxPage = -1;
  int page = 1;
  final List<GithubIssue> _repoIssuesCached = [];
  final _githubIssuesReposPublisher = PublishSubject<List<GithubIssue>>();
  late Query _query;
  late Filter _filter;

  late final GithubRepo repo;

  bool get isLoading => _isLoading;

  Stream<List<GithubIssue>> get stream => _githubIssuesReposPublisher.stream;

  IssueRepoViewModel(this.repo) {
    _query = Query(name: "");
    _query.addInner(name: "repo", value: repo.fullName);
    _query.addInner(name: "state", value: "open");
    _filter = Filter(
      query: _query,
      order: ORDER.desc,
    );
  }

  Future<void> initGithubIssuesRepo() async {
    if (!initFetchIsDone) {
      await _fetchIssuesRepo(page);
      page++;
      initFetchIsDone = true;
    }
  }

  Future<void> getIssuesRepo({bool restart = false}) async {
    if (restart) {
      page = 1;
      maxPage = -1;
    }
    if ((page < maxPage && maxPage != -1) || !_isLoading) {
      _isLoading = true;
      notifyListeners();
      await _fetchIssuesRepo(page, refresh: restart);
      page++;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchIssuesRepo(
    int page, {
    int perPage = 30,
    bool refresh = false,
  }) async {
    final result = await getIt<SearchIssueRepoInteractor>().invoke({
      "query": _filter.toString() + "&sort=created",
      "page": page,
      "per_page": perPage,
    });
    if (result is GithubIssuesResponse) {
      if (maxPage == -1) {
        maxPage = result.totalCount ?? -1;
      }
      if (refresh) {
        _repoIssuesCached.clear();
      }
      _repoIssuesCached.addAll(result.data);
      _githubIssuesReposPublisher.sink.add(_repoIssuesCached);
    } else {
      _githubIssuesReposPublisher.sink.addError((result as ErrorResponse).error);
    }
  }

  @override
  void dispose() {
    _githubIssuesReposPublisher.close();
    super.dispose();
  }
}
