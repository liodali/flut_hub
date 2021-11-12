import 'package:flut_hub_domain/src/models/github_filter.dart';
import 'package:flut_hub_domain/src/models/github_query.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test order next value", () {
    expect(ORDER.asc.nextValue, ORDER.none.value);
    expect(ORDER.none.nextValue, ORDER.desc.value);
    expect(ORDER.desc.nextValue, ORDER.asc.value);

    expect(ORDER.asc.nextOrder, ORDER.none);
    expect(ORDER.none.nextOrder, ORDER.desc);
    expect(ORDER.desc.nextOrder, ORDER.asc);
  });
  test("test sort next value", () {
    expect(SORT.forks.nextValue, SORT.none.value);
    expect(SORT.none.nextValue, SORT.stars.value);
    expect(SORT.stars.nextValue, SORT.forks.value);

    expect(SORT.forks.nextSort, SORT.none);
    expect(SORT.none.nextSort, SORT.stars);
    expect(SORT.stars.nextSort, SORT.forks);
  });
  test("test filter", () async {
    final Query query = Query(name: "flutter");
    final Filter filter = Filter(query: query);
    expect(filter.toString(), "q=flutter");

    query.addInner(name: "language", value: "java");
    filter.sort = SORT.stars;
    expect(filter.toString(), "q=flutter+language:java&sort=stars");
    filter.sort = SORT.none;
    query.addInner(name: "stars", value: "");

    expect(filter.toString(), "q=flutter+language:java");
  });
}
