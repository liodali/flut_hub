import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';
import '../../view_model/issue_repo_view_model.dart';
import '../common/loading_widget.dart';
import '../component/list_issues_repo.dart';

/// [IssuesGithubRepoWidget]
///
class IssuesGithubRepoWidget extends StatelessWidget {
  final ScrollController controller;

  const IssuesGithubRepoWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final issueVM = context.read<IssueRepoViewModel>();
    return NestedScrollView(
      headerSliverBuilder: (ctx, isInnerBoxScrolled) {
        return [
          SliverAppBar(
            title: Text.rich(
              TextSpan(
                text: "${issueVM.repo.name}\n",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey[400]!),
                children: [
                  TextSpan(
                    text: MyAppLocalizations.of(context)!.titleIssue,
                    children: [
                      TextSpan(
                        text: "\t(${issueVM.repo.openIssues})",
                        style: Theme.of(context).textTheme.bodyText1
                      )
                    ],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: RefreshIndicator(
        onRefresh: () async {
          final viewModel = context.read<IssueRepoViewModel>();
          await viewModel.getIssuesRepo(restart: true);
        },
        child: CustomScrollView(
          controller: controller,
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5.0,
              ),
              sliver: ListIssuesRepo(),
            ),
            SliverToBoxAdapter(
              child: Selector<IssueRepoViewModel, bool>(
                builder: (ctx, isLoading, _) {
                  if (!isLoading) {
                    return const SizedBox.shrink();
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: LoadingWidget(
                      loadingText: "",
                    ),
                  );
                },
                selector: (ctx, vm) => vm.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
