import 'package:dio/dio.dart';

mixin NetworkMixin {
  late final Dio _dio = Dio();

  String get server => "https://api.github.com/";

  Future<Response<T>> get<T>({
    required String endpoint,
    Map<String, dynamic>? query,
    CancelToken? token,
    Options? options,
  }) async{
    return _dio.get(
      "$server$endpoint",
      queryParameters: query,
      cancelToken: token,
      options: options,
    );
  }

}
