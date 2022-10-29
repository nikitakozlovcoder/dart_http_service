import 'package:injectable_http_service/src/types/body_serializer.type.dart';

import '../types/http_converter.type.dart';

abstract class HttpService<TSource> {
  Future<T> get<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers});
  Future<List<T>> getList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers});

  Future<T> post<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer});
  Future<List<T>> postList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer});

  Future<T> put<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer});
  Future<List<T>> putList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer});

  Future<T> delete<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer});
  Future<List<T>> deleteList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer});
}
