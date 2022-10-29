import 'dart:async';
import 'package:injectable_http_service/injectable_http_service.dart';
import 'package:http/http.dart' as http;

abstract class HttpServiceBase<TSource> implements HttpService<TSource> {
  final BodySerializer defaultBodySerializer;

  HttpServiceBase({this.defaultBodySerializer = noOpBodySerializer});

  @override
  Future<T> get<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers}) async {
    final req =
        await beforeHook(url, HttpVerb.get, null, headers, noOpBodySerializer);
    var response = await http.get(req.uri, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> getList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers}) async {
    final req =
        await beforeHook(url, HttpVerb.get, null, headers, noOpBodySerializer);
    var response = await http.get(req.uri, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  @override
  Future<T> delete<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer}) async {
    final req = await beforeHook(
        url, HttpVerb.delete, body, headers, chooseSerializer(bodySerializer));
    var response =
        await http.delete(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> deleteList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer}) async {
    final req = await beforeHook(
        url, HttpVerb.delete, body, headers, chooseSerializer(bodySerializer));
    var response =
        await http.delete(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  @override
  Future<T> post<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer}) async {
    final req = await beforeHook(
        url, HttpVerb.post, body, headers, chooseSerializer(bodySerializer));
    var response =
        await http.post(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> postList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer}) async {
    final req = await beforeHook(
        url, HttpVerb.post, body, headers, chooseSerializer(bodySerializer));
    var response =
        await http.post(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  @override
  Future<T> put<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer}) async {
    final req = await beforeHook(
        url, HttpVerb.put, body, headers, chooseSerializer(bodySerializer));
    var response =
        await http.put(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, converter);
  }

  @override
  Future<List<T>> putList<T>(String url, HttpConverter<T, TSource> converter,
      {Map<String, String>? headers,
      Object? body,
      BodySerializer? bodySerializer}) async {
    final req = await beforeHook(
        url, HttpVerb.put, body, headers, chooseSerializer(bodySerializer));
    var response =
        await http.put(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, converter);
  }

  FutureOr<AppHttpRequest> beforeHook(String url, HttpVerb verb, Object? body,
      Map<String, String>? headers, BodySerializer bodySerializer) async {
    if (body != null) {
      body = bodySerializer.call(body);
    }

    return AppHttpRequest(uri: Uri.parse(url), body: body, headers: headers);
  }

  FutureOr<http.Response> afterHook(http.Response response) async {
    return response;
  }

  TSource parseResult(http.Response response);
  List<TSource> parseListResult(http.Response response);

  BodySerializer chooseSerializer(BodySerializer? serializer) {
    return serializer ?? defaultBodySerializer;
  }

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
