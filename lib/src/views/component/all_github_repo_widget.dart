import 'package:flut_hub/src/view_model/home_view_model.dart';
import 'package:flut_hub/src/views/common/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_bar_search_home.dart';
import 'list_repos.dart';

/// [AllGithubRepoWidget]
/// this widget responsible  refresh list that include the list of repositories and appbar,
/// loading widget,when use try to refresh the list,
/// pagination will reset,and new call will send,
/// except that the query of repository in filter is empty or length < 4
/// it has [controller] parameter to controller customScrollView scroll
/// and used by the parent widget to animate to top position, when button is clicked by the user
class AllGithubRepoWidget extends StatelessWidget {
  final ScrollController controller;

  const AllGithubRepoWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return NestedScrollView(
        headerSliverBuilder: (ctx, isInnerBoxScrolled) {
          return [
            const AppBarSearchHome(),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            if (viewModel.filter.query.name.isNotEmpty && viewModel.filter.query.name.length >= 4) {
              await viewModel.getRepos(restart: true);
            }
          },
          child: CustomScrollView(
            controller: controller,
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5.0,
                ),
                sliver: ListRepos(),
              ),
              SliverToBoxAdapter(
                child: Selector<HomeViewModel, bool>(
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
        ));
  }
}
