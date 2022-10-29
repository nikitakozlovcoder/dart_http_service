## Usage


```dart
const http = HttpServiceImpl();

final myModel = await http.get<MyModel>('example.com', MyModel.fromJson);
```

or for DI with injectable package:

```dart
@module  
abstract class RegisterModule {  
  @Injectable(as: HttpService<JsonSource>)
  JsonHttpServiceImpl get httpService;  
}  

```
Also you can notice that injectable gives you an opprotunity to register HttpService with source type provided, so, you can have multiple http services for different responce types.

You can even extend it:

```dart
@named 
@Injectable(as: HttpService<JsonSource>)
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
class JsonHttpServiceImpl extends HttpServiceBase<JsonSource> {
  @override
  List<Map<String, dynamic>> parseListResult(Response response) {
    return jsonDecode(response.body).cast<Map<String, dynamic>>();
  }

  @override
  Map<String, dynamic> parseResult(Response response) {
    return jsonDecode(response.body);
  }
}
```

Real life usage:

```dart
@Injectable(as: LocationService)
class LocationServiceImpl implements LocationService {
  static const _apiBase = "https://api.openweathermap.org/";
  static const _locationEndpoint = "geo/1.0/direct";
  final HttpService<JsonSource> _httpService;

  LocationServiceImpl(
      @Named.from(OpenWeatherHttpServiceImpl) this._httpService);

  @override
  Future<LocationDto> getLocationByCityName(String cityname) async {
    final url = "$_apiBase$_locationEndpoint?q=$cityname";
    final responce = await _httpService.getList<LocationResponce>(
        url, LocationResponce.fromJson);
    final locationResponce = responce.first;

    return LocationDto(
        longtitute: locationResponce.lon, latitude: locationResponce.lat);
  }
}
```
