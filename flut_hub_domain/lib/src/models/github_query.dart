import '../common/utils.dart';
class Query {
  final String name;
  final List<InnerQuery> _inners = [];

  List<InnerQuery> get queryInners => _inners;

  Query({required this.name});

  Query.none() : name = "";

  Query copyWith({String? name}) {
    final query = Query(name: name ?? this.name);
    if (_inners.isNotEmpty) {
      for (var inner in _inners) {
        query.addInner(name: inner.name, value: inner.value);
      }
    }
    return query;
  }

  void addInner({
    required String name,
    required String value,
  }) {
    bool isExist = _inners.map((e) => e.name).contains(name);
    if (!isExist) {
      _inners.add(InnerQuery(name: name, value: value));
    }
    if (isExist) {
      int index = _inners.indexWhere((element) => element.name == name);
      _inners[index] = _inners[index].copyWith(
        value: value,
      );
    }
  }

  @override
  String toString() {
    String extra = "";
    if (_inners.isNotEmpty) {
      var cacheInners = _inners.where((element) => element.value.isNotEmpty);
      extra = "+" +
          cacheInners.toList().toInnerString();
    }
    return "q=$name$extra";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Query &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          _inners.toInnerString() == other._inners.toInnerString();

  @override
  int get hashCode => name.hashCode ^ _inners.hashCode;
}

class InnerQuery {
  final String name;
  final String value;

  InnerQuery({
    required this.name,
    required this.value,
  });

  InnerQuery copyWith({
    String? name,
    String? value,
  }) {
    return InnerQuery(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  dynamic getValue() {
    if (value.startsWith(">")) {
      int index = value.contains(">=") ? 2 : 1;
      double min = double.parse(value.substring(index));
      return min;
    }
    if (value.startsWith("<")) {
      int index = value.contains("<=") ? 2 : 1;
      double max = double.parse(value.substring(index));
      return -max;
    }
    if (value.contains("..")) {
      var values = value.split("..");
      return values.where((element) => element.isNotEmpty).map((e) => double.parse(e)).toList();
    }
  }

  @override
  String toString() {
    return "$name:$value";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InnerQuery &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value;

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
