import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';
import '../../view_model/adv_filter_view_model.dart';
import '../../view_model/home_view_model.dart';
import '../component/stars_query_form_widget.dart';
import 'language_query_widget.dart';
import 'order_filter_widget.dart';
import 'sort_filter_widget.dart';

/// [AdvancedFilterRepo]
/// this widget responsible to show advanced option to make search for repositories
/// it manage her state with hookWidget with combination of AdvFilterViewModel
/// when apply button clicked it will generate new Filter object and compared with previous one
/// if not identical and name repo is not empty , new request to get new repositories will send
/// if identical nothing happen
class AdvancedFilterRepo extends HookWidget {
  const AdvancedFilterRepo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeVM = context.read<HomeViewModel>();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(24.0),
        topLeft: Radius.circular(24.0),
      ),
      child: Column(
        children: [
          AppBar(
            leading: const SizedBox.shrink(),
            centerTitle: true,
            title: Text(MyAppLocalizations.of(context)!.titleAdvFilter),
            backgroundColor: Theme.of(context).backgroundColor,
            actions: [
              Selector<AdvFilterViewModel, bool>(
                selector: (cx, vm) => vm.canSub,
                shouldRebuild: (o, n) => true,
                builder: (ctx, canSub, _) {
                  return FloatingActionButton(
                    onPressed: canSub
                        ? () async {
                            final vm = context.read<AdvFilterViewModel>();
                            Filter filter = vm.generateNewFilter().copyWith();
                            bool isSameFilter = vm.isSameFilter(filter);
                            if (!isSameFilter) {
                              homeVM.setFilter(
                                filter.query,
                                order: filter.order,
                                sort: filter.sort,
                              );
                              if (filter.query.name.isNotEmpty && filter.query.name.length >= 4) {
                                homeVM.getRepos(restart: true);
                              }
                            }

                            Navigator.pop(context);
                          }
                        : null,
                    backgroundColor: Theme.of(context).colorScheme.primaryVariant,
                    elevation: 0.0,
                    child: const Icon(
                      Icons.done,
                    ),
                    mini: true,
                  );
                },
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: const [
                        StarsQueryFormWidget(),
                        SizedBox(
                          height: 12,
                        ),
                        LanguageQueryWidget(),
                        SizedBox(
                          height: 12,
                        ),
                        SortFilterWidget(),
                        SizedBox(
                          height: 12,
                        ),
                        OrderFilterWidget(),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
