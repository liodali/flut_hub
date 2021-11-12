import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'loading_widget.dart';

typedef BikeBuilder<T> = Widget Function(T data);
typedef MapTo<T> = T Function(IResponse data);

class MyFutureBuilderComponent<T> extends HookWidget {
  final BikeBuilder<T> builder;
  final Widget? errorWidget;
  final Widget? loading;
  final Future<IResponse> future;
  final MapTo<T> mapTo;

  const MyFutureBuilderComponent({
    required this.future,
    required this.builder,
    required this.mapTo,
    this.loading,
    this.errorWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _hookFuture = useMemoized(() => future, [key]);
    final snap = useFuture(_hookFuture);
    if (snap.connectionState == ConnectionState.waiting) {
      return loading ?? const LoadingWidget();
    } else if (snap.connectionState == ConnectionState.done) {
      if (snap.hasData) {
        final data = snap.data;
        if ((data is ErrorResponse)) {
          return errorWidget ?? Text("${data.error}");
        }
        return builder(mapTo(snap.data!));
      }
      return errorWidget ?? const Text("Opps!error");
    }
    return errorWidget ?? const Text("Opps!error");
  }
}
