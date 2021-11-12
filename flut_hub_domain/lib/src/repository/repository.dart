import '../models/response.dart';

abstract class Repository {
  Future<IResponse> getAll();
}
