import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../common/flut_hub_icons_icons.dart';
import '../../common/utils.dart';
import '../../view_model/issue_repo_view_model.dart';
import '../component/issues_github_repo_widget.dart';

class IssuesRepository extends HookWidget {
  const IssuesRepository({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final offset = useState(0.0);
    final viewModel = useRef(context.read<IssueRepoViewModel>());
    final showFab = useState(false);
    final offsetListener = useCallback(() async {
      offset.value = controller.offset;
    }, []);
    useEffect(() {
      controller.addListener(offsetListener);
      return () => controller.removeListener(offsetListener);
    }, [controller]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          NotificationListener<ScrollUpdateNotification>(
            onNotification: (updateScrollNotif) {
              if (updateScrollNotif.metrics.pixels >= sizeItem * 5) {
                showFab.value = true;
              }
              if (updateScrollNotif.metrics.pixels < sizeItem * 5) {
                showFab.value = false;
              }
              return true;
            },
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (notif) {
                if (notif.metrics.pixels > (notif.metrics.maxScrollExtent - 50) &&
                    notif.metrics.axisDirection == AxisDirection.down &&
                    !viewModel.value.isLoading) {
                  print(
                      "${notif.metrics.pixels},${notif.metrics.maxScrollExtent} : fetch ${viewModel.value.page}");
                  Future.microtask(() async => await viewModel.value.getIssuesRepo());
                }
                return true;
              },
              child: IssuesGithubRepoWidget(
                controller: controller,
              ),
            ),
          ),
          Positioned(
            bottom: 12.0,
            right: 8.0,
            child: AnimatedContainer(
              width: showFab.value ? 64 : 0.0,
              height: showFab.value ? 48 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                  fixedSize: const Size(32, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  controller.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceInOut,
                  );
                },
                child: Icon(
                  FlutHubIcons.upArrow,
                  color: Colors.grey[400]!,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
