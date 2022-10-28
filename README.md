## Usage


```dart
const http = HttpServiceImpl();

final myModel = http.get<MyModel>('example.com', MyModel.fromJson);
```

or for DI with injectable package:

```dart
@module  
abstract class RegisterModule {  
  @Injectable(as: HttpService)
  HttpServiceImpl get httpService;  
}  

```

You can even extend it:

```dart

@named 
@Injectable(as: HttpService)
class OpenWeatherHttpServiceImpl extends HttpServiceImpl {

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

