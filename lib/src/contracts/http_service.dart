typedef Converter<T, TSource> = T Function(TSource);

abstract class HttpService<TSource> {
  Future<T> get<T>(String url, Converter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> getList<T>(String url, Converter<T, TSource> converter,
      [Map<String, String>? headers]);

  Future<T> post<T>(String url, Object? body, Converter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> postList<T>(
      String url, Object? body, Converter<T, TSource> converter,
      [Map<String, String>? headers]);

  Future<T> put<T>(String url, Object? body, Converter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> putList<T>(
      String url, Object? body, Converter<T, TSource> converter,
      [Map<String, String>? headers]);

  Future<T> delete<T>(String url, Object? body, Converter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> deleteList<T>(
      String url, Object? body, Converter<T, TSource> converter,
      [Map<String, String>? headers]);
}
