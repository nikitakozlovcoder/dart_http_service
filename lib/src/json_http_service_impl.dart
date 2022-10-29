import 'dart:convert';
import 'package:http/http.dart';
import 'package:injectable_http_service/src/base/http_service_base.dart';

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
