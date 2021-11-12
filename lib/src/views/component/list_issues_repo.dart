import 'package:flut_hub/src/common/utils.dart';
import 'package:flut_hub/src/view_model/issue_repo_view_model.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/routes.dart';
import '../common/loading_widget.dart';
import '../common/stream_component.dart';
import 'item_issue_repo.dart';

class ListIssuesRepo extends HookWidget {
  const ListIssuesRepo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<IssueRepoViewModel>(context);
    useEffect(() {
      viewModel.initGithubIssuesRepo();
    }, [context]);
    return StreamComponent<List<GithubIssue>>(
      stream: viewModel.stream,
      loading: const SliverFillRemaining(
        fillOverscroll: false,
        hasScrollBody: false,
        child: LoadingWidget(),
      ),
      errorWidget: const SliverFillRemaining(
        fillOverscroll: false,
        hasScrollBody: false,
        child: Center(
          child: Text("Error!"),
        ),
      ),
      builder: (issues) {
        if (issues.isEmpty && viewModel.isLoading) {
          return const SliverFillRemaining(
            child: LoadingWidget(),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) {
               return HookBuilder(
                 builder: (ctx){
                   final issue = useMemoized(()=>issues[index]);
                   return SizedBox(
                     height: sizeItem,
                     child: ItemIssueRepo(
                       issue: issue,
                       repoName: viewModel.repo.fullName,
                     ),
                   );
                 },
               );
            },
            childCount: issues.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
          ),
        );
      },
    );
  }
}
