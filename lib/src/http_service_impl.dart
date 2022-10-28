import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../injectable_http_service.dart';


class HttpServiceImpl implements HttpService {

  @override
  Future<T> get<T>(String url, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.get, null, headers);
    var response = await http.get(req.uri, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, jsonConverter);
  }
  
  @override
  Future<List<T>> getList<T>(String url, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.get, null, headers);
    var response = await http.get(req.uri, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, jsonConverter);
  }
  
  @override
  Future<T> delete<T>(String url, Object? body, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.delete, body, headers);
    var response = await http.delete(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, jsonConverter);
  }
  
  @override
  Future<List<T>> deleteList<T>(String url, Object? body, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.delete, body, headers);
    var response = await http.delete(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildListResult<T>(response, jsonConverter);
  }
  
  @override
  Future<T> post<T>(String url, Object? body, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.post, body, headers);
    var response = await http.post(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);

    return _buildResult<T>(response, jsonConverter);
  }
  
  @override
  Future<List<T>> postList<T>(String url, Object? body, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.post, body, headers);
    var response = await http.post(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);
   
    return _buildListResult<T>(response, jsonConverter);
  }
  
  @override
  Future<T> put<T>(String url, Object? body, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.put, body, headers);
    var response = await http.put(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);
   
    return _buildResult<T>(response, jsonConverter);
  }
  
  @override
  Future<List<T>> putList<T>(String url, Object? body, JsonConverter<T> jsonConverter, [Map<String, String>? headers]) async {
    final req = await beforeHook(url, HttpVerb.put, body, headers);
    var response = await http.put(req.uri, body: req.body, headers: req.headers);
    response = await afterHook(response);
   
    return _buildListResult<T>(response, jsonConverter);
  }

  FutureOr<AppHttpRequest> beforeHook(String url, HttpVerb verb, Object? body, Map<String, String>? headers) async {
    return AppHttpRequest(uri: Uri.parse(url));
  }

  FutureOr<http.Response> afterHook(http.Response response) async {
    return response;
  }

  T _buildResult<T>(http.Response response, JsonConverter<T> jsonConverter) {
    final json = jsonDecode(response.body);

    return jsonConverter.call(json);
  }

  List<T> _buildListResult<T>(http.Response response, JsonConverter<T> jsonConverter) {
    final json = jsonDecode(response.body);
    final list = List<T>.generate(json.length,
      (index) => jsonConverter.call(json[index]));
  
    return list;
  }
}