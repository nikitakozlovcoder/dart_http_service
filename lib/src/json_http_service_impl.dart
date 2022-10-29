import 'dart:convert';
import 'package:http/http.dart';
import 'base/http_service_base.dart';
import 'types/json_source.type.dart';

class JsonHttpServiceImpl extends HttpServiceBase<JsonSource> {
  JsonHttpServiceImpl({super.defaultBodySerializer});

  @override
  List<Map<String, dynamic>> parseListResult(Response response) {
    return jsonDecode(response.body).cast<Map<String, dynamic>>();
  }

  @override
  Map<String, dynamic> parseResult(Response response) {
    return jsonDecode(response.body);
  }
}
