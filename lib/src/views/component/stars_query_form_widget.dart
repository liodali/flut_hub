import 'package:flut_hub/src/view_model/adv_filter_view_model.dart';
import 'package:flut_hub/src/views/common/text_field_flut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';

class StarsQueryFormWidget extends HookWidget {
  const StarsQueryFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final advFilterVM = context.read<AdvFilterViewModel>();
    var min = 0.0, max = 0.0;
    if (advFilterVM.query.queryInners.isNotEmpty) {
      final innerQ =
          advFilterVM.query.queryInners.where((element) => element.name == "stars").first;
      final value = innerQ.getValue();
      if (value is double) {
        if (value > 0) {
          min = value;
        }
        if (value < 0) {
          max = -value;
        }
      }
      if (value is List) {
        min = value.first;
        max = value.last;
      }
    }
    final textControllerMin = useTextEditingController(text: "$min");
    final textControllerMax = useTextEditingController(text: "$max");
    advFilterVM.setMinStars(min);
    advFilterVM.setMaxStars(max);
    final isErrorMin = useState(false);
    final isErrorMax = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MyAppLocalizations.of(context)!.starsTitleFilter,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: TextFieldFlut(
                textController: textControllerMin,
                hint: MyAppLocalizations.of(context)!.hintMinTextField,
                label: MyAppLocalizations.of(context)!.hintMinTextField,
                typeKeyboard: TextInputType.number,
                error: isErrorMin.value ? "min should inf of ${advFilterVM.max}" : null,
                onSubmit: (value) {
                  textControllerMin.text = value;
                  final minValue = double.parse(value);
                  if (value.isNotEmpty) {
                    advFilterVM.blockSubmit(false) ;
                    isErrorMin.value = false;
                    if (minValue > 0 && advFilterVM.max != null && advFilterVM.max!>0  && advFilterVM.max! < minValue) {
                      isErrorMin.value = true;
                      advFilterVM.blockSubmit(true) ;
                    }
                    advFilterVM.setMinStars(minValue);
                  }
                  if (value.isEmpty) {
                    advFilterVM.setMinStars(null);
                  }
                },
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              ),
            ),
            Expanded(
              child: TextFieldFlut(
                textController: textControllerMax,
                hint: MyAppLocalizations.of(context)!.hintMaxTextField,
                label: MyAppLocalizations.of(context)!.hintMaxTextField,
                typeKeyboard: TextInputType.number,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 2.0,
                ),
                onSubmit: (value) {
                  textControllerMax.text = value;
                  if(value.isNotEmpty){
                    final maxValue = double.parse(value);
                    advFilterVM.blockSubmit(false) ;
                    isErrorMax.value = false;
                    if (maxValue > 0 && advFilterVM.min != null && advFilterVM.min! > maxValue) {
                      isErrorMax.value = true;
                      advFilterVM.blockSubmit(true) ;
                    }
                    advFilterVM.setMaxStars(maxValue);
                  }
                  if (value.isEmpty) {
                    advFilterVM.setMinStars(null);
                  }
                },
                error: isErrorMax.value ? "max should sup of ${advFilterVM.min}" : null,
              ),
            ),
          ],
        )
      ],
    );
  }
}
