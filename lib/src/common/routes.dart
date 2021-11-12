import 'package:flut_hub/src/view_model/issue_repo_view_model.dart';
import 'package:flut_hub/src/views/pages/issues_repository.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static const String repoIssuesNamePage = "issue-repo";
  static const String homePage = "";

  static Route<dynamic>? routes(RouteSettings setting) {
    var arguments = setting.arguments;
    switch (setting.name) {
      case repoIssuesNamePage:
        return MaterialPageRoute(builder: (ctx) {
          return ChangeNotifierProvider(
            create: (ctx) => IssueRepoViewModel(arguments as GithubRepo),
            child: const IssuesRepository(),
          );
        });
    }
  }
}

extension MyAppRouter on BuildContext {
  Future<T?> navigate<T>(
    String path, {
    dynamic arguments,
  }) async {
    return Navigator.pushNamed<T>(this, path, arguments: arguments);
  }

  Future<T?> navigateAndPop<T, R>(
    String path, {
    dynamic arguments,
    R? result,
  }) async {
    return Navigator.popAndPushNamed<T, R?>(this, path, arguments: arguments, result: result);
  }

  Future<void> pop<T>({T? result}) async {
    return Navigator.pop<T?>(this, result);
  }
}
