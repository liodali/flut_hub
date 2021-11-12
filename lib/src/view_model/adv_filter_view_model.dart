import 'package:flut_hub_domain/flut_hub_domain.dart';
import 'package:flutter/material.dart';

class AdvFilterViewModel extends ChangeNotifier {
  late Query _query;
  late SORT? _sort;
  late ORDER? _order;

  double? min;
  double? max;
  String? language;

  bool canSub = true;
  late final Filter _previousFilter;
  AdvFilterViewModel(Filter filter) {
    _previousFilter = filter.copyWith();
    _query = filter.query.copyWith();
    _sort = filter.sort;
    _order = filter.order;
    language = _query.queryInners
        .firstWhere(
          (element) => element.name == "language",
          orElse: () => InnerQuery(name: "language", value: ""),
        )
        .value;
  }

  Query get query => _query;

  SORT? get sort => _sort;

  ORDER? get order => _order;

  void setMinStars(double? min) {
    this.min = min;
  }

  void setMaxStars(double? max) {
    this.max = max;
  }

  void blockSubmit(bool block) {
    canSub = !block;
    notifyListeners();
  }

  void setLanguage(String? lg) {
    language = lg;
  }

  void setSort(SORT s) {
    _sort = s;
  }

  void setOrder(ORDER order) {
    _order = order;
  }

  /// generateNewFilter
  /// this method will transform input user in bottomSheet to Filter Object
  /// this method return new filter object desired by the user
  /// return Filter that represent parameter of github search repo api
  /// Filter always non null value, but it can contain nullable attributes such as sort and order
  Filter generateNewFilter() {
    final query = _query.copyWith();
    if (language != null) {
      query.addInner(name: "language", value: language!);
    }
    if (min != null && min! > 0) {
      query.addInner(name: "stars", value: ">${min!.toInt()}");
    }
    if (max != null && max! > 0) {
      query.addInner(name: "stars", value: "<${max!.toInt()}");
    }
    if (min != null && max != null) {
      if (min == 0.0 && max == 0.0) {
        query.addInner(name: "stars", value: "");
      } else if (min! > 0.0 && max! > 0.0) {
        query.addInner(name: "stars", value: "${min!.toInt()}..${max!.toInt()}");
      }
    }

    return Filter(
      query: query,
      sort: sort,
      order: order,
    );
  }

  bool isSameFilter(Filter filter) => filter == _previousFilter;

}
