import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/flut_hub_icons_icons.dart';
import '../../view_model/adv_filter_view_model.dart';
import '../../view_model/home_view_model.dart';
import '../common/badge_filter.dart';
import 'advanced_filter_repo.dart';

class BottomSearchAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size size;

  const BottomSearchAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeVM = context.read<HomeViewModel>();

    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
      ),
      child: SizedBox(
        width: Size.infinite.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (var inner in homeVM.filter.query.queryInners) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: GestureDetector(
                    onTap: () async {
                      await showAdvFilterBottomSheet(context,homeVM);
                    },
                    child: Selector<HomeViewModel, InnerQuery>(
                      selector: (ctx, vm) => vm.filter.query.queryInners
                          .where((element) => element.name == inner.name)
                          .first,
                      shouldRebuild: (o, n) => o.value != n.value,
                      builder: (ctx, innerQuery, _) {
                        return BadgeFilter(
                          color: innerQuery.value.isNotEmpty
                              ? Theme.of(context).backgroundColor
                              : null,
                          shape: innerQuery.value.isNotEmpty
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                  side: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                    width: 0.6,
                                  ),
                                )
                              : null,
                          title: Text(innerQuery.toString()),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        );
                      },
                    ),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: GestureDetector(
                  onTap: () {
                    homeVM.setFilter(
                      homeVM.filter.query,
                      sort: homeVM.filter.sort?.nextSort,
                    );
                  },
                  child: Selector<HomeViewModel, Filter>(
                    selector: (ctx, vm) => vm.filter,
                    shouldRebuild: (old, newFilter) => old.sort != newFilter.sort,
                    builder: (ctx, filter, _) {
                      final text =
                          filter.sort != null && filter.sort != SORT.none ? filter.sort!.value : "";

                      return BadgeFilter(
                        color: filter.sort != null && filter.sort != SORT.none
                            ? Theme.of(context).backgroundColor
                            : null,
                        shape: filter.sort != null && filter.sort != SORT.none
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 0.6,
                                ),
                              )
                            : null,
                        title: Text("sort:$text"),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: GestureDetector(
                  onTap: () {
                    homeVM.setFilter(
                      homeVM.filter.query,
                      order: homeVM.filter.order?.nextOrder,
                    );
                  },
                  child: Selector<HomeViewModel, Filter>(
                    selector: (ctx, vm) => vm.filter,
                    shouldRebuild: (old, newFilter) => old.order != newFilter.order,
                    builder: (ctx, filter, child) {
                      final String text = filter.order != null && filter.order != ORDER.none
                          ? filter.order!.value
                          : "";

                      return BadgeFilter(
                        color: filter.order != null && filter.order != ORDER.none
                            ? Theme.of(context).backgroundColor
                            : null,
                        shape: filter.order != null && filter.order != ORDER.none
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(26),
                                side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 0.6,
                                ),
                              )
                            : null,
                        title: Text(
                          "order:$text",
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 1.0),
                onPressed: () async {
                  await showAdvFilterBottomSheet(context,homeVM);
                },
                icon: const Icon(
                  FlutHubIcons.more,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future showAdvFilterBottomSheet(context,HomeViewModel homeVM) async {

    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.0),
            topLeft: Radius.circular(24.0),
          ),
        ),
        builder: (ctx) {
          return ChangeNotifierProvider(
            create: (ctx) => AdvFilterViewModel(homeVM.filter.copyWith()),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 3,
                maxHeight: MediaQuery.of(context).size.height / 1.5,
              ),
              child: DraggableScrollableSheet(
                minChildSize: 1.0,
                maxChildSize: 1.0,
                initialChildSize: 1.0,
                builder: (ctx, controller) {
                  return const AdvancedFilterRepo();
                },
              ),
            ),
          );
        });
  }

  @override
  Size get preferredSize => size;
}
