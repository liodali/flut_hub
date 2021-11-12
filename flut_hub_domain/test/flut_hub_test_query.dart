import 'package:flut_hub_domain/src/models/github_query.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test query", () async {
    final Query query = Query(name: "flutter");

    expect(query.toString(), "q=flutter");

    query.addInner(name: "language", value: "java");

    expect(query.toString(), "q=flutter+language:java");

    query.addInner(name: "stars", value: ">1000");

    expect(query.toString(), "q=flutter+language:java+stars:>1000");
  });
}
