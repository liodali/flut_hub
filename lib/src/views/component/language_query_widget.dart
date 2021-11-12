import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';
import '../../common/utils.dart';
import '../../view_model/adv_filter_view_model.dart';
import '../common/badge_filter.dart';

class LanguageQueryWidget extends HookWidget {
  const LanguageQueryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final advFilterVM = context.read<AdvFilterViewModel>();

    final languageState = useState(advFilterVM.language ?? "");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MyAppLocalizations.of(context)!.languageTitleFilter,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          runAlignment: WrapAlignment.start,
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          runSpacing: 5.0,
          children: [
            for (var lg in languages) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () {
                    languageState.value = lg;
                    advFilterVM.setLanguage(lg);
                  },
                  child: BadgeFilter(
                    color: lg == languageState.value ? Theme.of(context).backgroundColor : null,
                    shape: lg == languageState.value
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
                      width: 64,
                      height: 32,
                      child: Center(
                        child: AutoSizeText(lg.isNotEmpty ? lg : "None"),
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
