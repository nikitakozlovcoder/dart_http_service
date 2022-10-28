class AppHttpRequest {
  Uri uri;
  Map<String, String>? headers;
  Object? body;
  AppHttpRequest({required this.uri, this.headers, this.body});
}