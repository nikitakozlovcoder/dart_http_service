import 'dart:async';
import 'package:injectable_http_service/injectable_http_service.dart';
import 'package:http/http.dart' as http;
import '../types/http_converter.type.dart';

abstract class HttpServiceBase<TSource> implements HttpService<TSource> {
  @override
  Future<T> get<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers}) async {
    final req = await beforeHook(url, HttpVerb.get, null, headers);
    var response = await http.get(req.uri, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> getList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers}) async {
    final req = await beforeHook(url, HttpVerb.get, null, headers);
    var response = await http.get(req.uri, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  @override
  Future<T> delete<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers, Object? body}) async {
    final req = await beforeHook(url, HttpVerb.delete, body, headers);
    var response =
        await http.delete(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> deleteList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers, Object? body}) async {
    final req = await beforeHook(url, HttpVerb.delete, body, headers);
    var response =
        await http.delete(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  @override
  Future<T> post<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers, Object? body}) async {
    final req = await beforeHook(url, HttpVerb.post, body, headers);
    var response =
        await http.post(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> postList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers, Object? body}) async {
    final req = await beforeHook(url, HttpVerb.post, body, headers);
    var response =
        await http.post(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  @override
  Future<T> put<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers, Object? body}) async {
    final req = await beforeHook(url, HttpVerb.put, body, headers);
    var response =
        await http.put(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> putList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers, Object? body}) async {
    final req = await beforeHook(url, HttpVerb.put, body, headers);
    var response =
        await http.put(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  FutureOr<AppHttpRequest> beforeHook(String url, HttpVerb verb, Object? body,
      Map<String, String>? headers) async {
    return AppHttpRequest(uri: Uri.parse(url));
  }

  FutureOr<http.Response> afterHook(http.Response response) async {
    return response;
  }

  TSource parseResult(http.Response response);
  List<TSource> parseListResult(http.Response response);

  T _buildResult<T>(
      http.Response response, HttpConverter<T, TSource> converter) {
    final data = parseResult(response);

    return converter.call(data);
  }

  List<T> _buildListResult<T>(
      http.Response response, HttpConverter<T, TSource> converter) {
    final data = parseListResult(response);
    final list =
        List<T>.generate(data.length, (index) => converter.call(data[index]));

    return list;
  }
}
