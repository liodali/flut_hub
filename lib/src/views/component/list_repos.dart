import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/routes.dart';
import '../../view_model/home_view_model.dart';
import '../common/loading_widget.dart';
import '../common/stream_component.dart';
import 'item_repo.dart';

class ListRepos extends HookWidget {
  const ListRepos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    useEffect(() {
      viewModel.initGithubRepos();
    }, [context]);
    return StreamComponent<List<GithubRepo>>(
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
      builder: (repos) {
        if (repos.isEmpty && viewModel.isLoading) {
          return const SliverFillRemaining(
            child: LoadingWidget(),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) {
              final repo = repos[index];
              return GestureDetector(
                onTap: () async {
                  await context.navigate(
                    AppRouter.repoIssuesNamePage,
                    arguments: repo,
                  );
                },
                child: SizedBox(
                  height: 172,
                  child: ItemRepo(
                    repo: repo,
                  ),
                ),
              );
            },
            childCount: repos.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
          ),
        );
      },
    );
  }
}
