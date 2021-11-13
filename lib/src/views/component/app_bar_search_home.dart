import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/app_localization.dart';
import '../../common/flut_hub_icons_icons.dart';
import '../../common/job_timer.dart';
import '../../view_model/home_view_model.dart';
import '../common/search_text_repo.dart';
import 'bottom_search_app_bar.dart';

class AppBarSearchHome extends HookWidget {
  const AppBarSearchHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeVM = context.read<HomeViewModel>();
    ValueNotifier<bool> showCloseSearch = useValueNotifier(false);
    final textController = useTextEditingController();
    final leadingWidthState = useState(5.0);
    final appTimer = useRef(JobTimer.minimum(duration: const Duration(seconds: 2)));
    final searchJOB = useCallback(() async {
      String text = textController.value.text;
      if (text.isNotEmpty && text.length >= 4) {
        bool restart = homeVM.filter.query.name != text;
        var query = homeVM.filter.query.copyWith(name: text);
        homeVM.setFilter(query);
        await homeVM.getRepos(restart: restart);
      }
      appTimer.value.dispose;
    }, []);
    return SliverAppBar(
      leading: ValueListenableBuilder<bool>(
        valueListenable: showCloseSearch,
        builder: (ctx, showCancelBt, child) {
          if (showCancelBt) {
            return child!;
          }
          return const SizedBox.shrink();
        },
        child: IconButton(
          onPressed: () {
            if (textController.text.isNotEmpty) {
              textController.text = "";
              homeVM.setFilter(
                homeVM.filter.query.copyWith(name: ""),
                sort: homeVM.filter.sort,
                order: homeVM.filter.order,
              );
            }
            leadingWidthState.value = 5.0;
            showCloseSearch.value = false;
            FocusScope.of(context).requestFocus(FocusNode());
          },
          icon: const Icon(FlutHubIcons.leftArrow),
        ),
      ),
      leadingWidth: leadingWidthState.value,
      title: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: SearchTextRepo(
          textController: textController,
          onTap: () {
            if (!showCloseSearch.value) {
              leadingWidthState.value = 48.0;
              showCloseSearch.value = true;
            }
          },
          onChange: (searchText) async {
            if (searchText.isNotEmpty && searchText.length >= 4) {
              appTimer.value.setJobCallback(searchJOB);
              appTimer.value.run();
            }
          },
          onSubmit: (_) {},
          hint: MyAppLocalizations.of(context)!.hintSearchRepoTextField,
          radius: 24,
        ),
      ),
      pinned: true,
      floating: false,
      forceElevated: true,
      elevation: 2,
      bottom: const BottomSearchAppBar(
        size: Size.fromHeight(48.0),
      ),
    );
  }
}
