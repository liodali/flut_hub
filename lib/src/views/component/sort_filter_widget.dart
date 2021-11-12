import 'package:flut_hub/src/view_model/adv_filter_view_model.dart';
import 'package:flut_hub/src/views/common/badge_filter.dart';
import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';

class SortFilterWidget extends HookWidget {
  const SortFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final advFilterVM = context.read<AdvFilterViewModel>();

    final sortState = useState(advFilterVM.sort ?? SORT.none);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MyAppLocalizations.of(context)!.sortTitleFilter,
          style: Theme.of(context).textTheme.headline6,
        ),
        const  SizedBox(
          height: 12,
        ),
        Row(
          children: [
            for (var s in SORT.values) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () {
                    sortState.value = s;
                    advFilterVM.setSort(s);

                  },
                  child: BadgeFilter(
                    color: s == sortState.value ? Theme.of(context).backgroundColor : null,
                    shape: s == sortState.value
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 0.6,
                            ),
                          )
                        : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                    title: SizedBox(
                      width: 72,
                      height: 48,
                      child: Center(
                        child: Text(s.value.isNotEmpty ? s.value : "None"),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                  ),
                ),
              )
            ],
          ],
        )
      ],
    );
  }
}
