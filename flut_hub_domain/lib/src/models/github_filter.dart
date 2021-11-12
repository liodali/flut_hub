import 'package:flut_hub_domain/src/models/github_query.dart';

enum SORT { stars, forks, none }


extension ValuesSORT on SORT {
  static const values = ["stars", "forks", ""];

  String get value => values[index];

  String get nextValue => (index + 1) < values.length ? values[index + 1] : values[0];

  SORT get nextSort => (index + 1) < values.length ? SORT.values[index + 1] : SORT.values[0];
}

enum ORDER { desc, asc, none }

extension ValuesORDER on ORDER {
  static const values = ["desc", "asc", ""];

  String get value => values[index];

  String get nextValue => (index + 1) < values.length ? values[index + 1] : values[0];

  ORDER get nextOrder => (index + 1) < values.length ? ORDER.values[index + 1] : ORDER.values[0];
}

/// this class Filter will be use to generate parameter of github search api
/// the user input and selection will be transform it to this object
/// that will be generate query that will be add it to api call of  /search/repositories
/// params
/// [query] :
///
/// [sort] :
///
/// [order] :
class Filter {
  final Query query;
  SORT? sort;
  ORDER? order;

  Filter({
    required this.query,
    this.sort,
    this.order,
  });

  Filter.none() : query = Query.none();

  Filter copyWith({
    Query? query,
    SORT? sort,
    ORDER? order,
  }) {
    return Filter(
      query: query ?? this.query,
      sort: sort ?? this.sort,
      order: order ?? this.order,
    );
  }

  @override
  String toString() {
    var filter = query.toString();
    if (sort != null && sort!.value.isNotEmpty) {
      filter += "&sort=${sort!.value}";
    }
    if (order != null && order!.value.isNotEmpty) {
      filter += "&order=${order!.value}";
    }

    return filter;
  }

  @override
  bool operator ==(Object other) {
    Filter otherFilter = other as Filter;
    return otherFilter.sort == sort && otherFilter.order == order && query == otherFilter.query;
  }

  @override
  int get hashCode => query.hashCode ^ sort.hashCode ^ order.hashCode;
}
