## Usage


```dart
const http = HttpServiceImpl();

final myModel = await http.get<MyModel>('example.com', MyModel.fromJson);
```

or for DI with injectable package:

```dart
@module  
abstract class RegisterModule {  
  @Injectable(as: HttpService)
  JsonHttpServiceImpl get httpService;  
}  

```

You can even extend it:

```dart
@named 
@Injectable(as: HttpService)
class OpenWeatherHttpServiceImpl extends JsonHttpServiceImpl {

  @override
  FutureOr<AppHttpRequest> beforeHook(String url, HttpVerb verb,  Object? body, Map<String, String>? headers) async {
    final req = await super.beforeHook(url, verb, body, headers);
    final uri = req.uri.replace(queryParameters: {...req.uri.queryParameters}
      ..putIfAbsent('appid', () => '********'));
      
    return AppHttpRequest(
      uri: uri,
      body: req.body,
      headers: req.headers
    );
  }
}

```

To support any responce formats you can extend HttpServiceBase<TSource> class:


```dart
class JsonHttpServiceImpl extends HttpServiceBase<Map<String, dynamic>> {
  @override
  List<Map<String, dynamic>> parseListResult(Response response) {
    return jsonDecode(response.body);
  }

  @override
  Map<String, dynamic> parseResult(Response response) {
    return jsonDecode(response.body);
  }
}
```
