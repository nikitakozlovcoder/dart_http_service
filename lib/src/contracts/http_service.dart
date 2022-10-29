import '../types/http_converter.type.dart';

abstract class HttpService<TSource> {
  Future<T> get<T>(String url, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> getList<T>(String url, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);

  Future<T> post<T>(
      String url, Object? body, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> postList<T>(
      String url, Object? body, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);

  Future<T> put<T>(
      String url, Object? body, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> putList<T>(
      String url, Object? body, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);

  Future<T> delete<T>(
      String url, Object? body, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);
  Future<List<T>> deleteList<T>(
      String url, Object? body, HttpConverter<T, TSource> converter,
      [Map<String, String>? headers]);
}
