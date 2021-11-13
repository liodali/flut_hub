import 'package:auto_size_text/auto_size_text.dart';
import 'package:flut_hub/src/common/utils.dart';
import 'package:flut_hub/src/view_model/home_view_model.dart';
import 'package:flut_hub/src/views/common/my_future_builder_component.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTextItemRepo extends StatelessWidget {
  final String repoFullName;

  const SearchTextItemRepo({
    Key? key,
    required this.repoFullName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget = AutoSizeText(
      repoFullName,
      style: Theme.of(context).textTheme.headline6,
      minFontSize: 14,
      maxFontSize: 18,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    return Selector<HomeViewModel, Filter>(
      selector: (ctx, vm) => vm.filter,
      shouldRebuild: (oldFilter, nFilter) => oldFilter != nFilter,
      builder: (ctx, filter, child) {
        final homeVM = context.read<HomeViewModel>();
        final searchableText = filter.query.name;
        if (searchableText.isEmpty || homeVM.isLoading) {
          return widget;
        }
        return MyFutureBuilderComponent<List<TextSpan>>(
          future: compute(
            computeTextColorationSearch,
            [
              repoFullName,
              searchableText,
              Theme.of(context).primaryColor,
            ],
          ),
          loading: widget,
          builder: (spans) {
            return AutoSizeText.rich(
              TextSpan(children: spans),
              style: Theme.of(context).textTheme.headline6,
              minFontSize: 14,
              maxFontSize: 18,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        );
      },
    );
  }
}
