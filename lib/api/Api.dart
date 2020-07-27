import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:http/src/response.dart';

import 'AppException.dart';

class ApiBaseHelper {

  Client http_client = Client();
  final String _baseUrl = "https://a7a8781a-ac7f-413b-a677-f5b4c8668d3a.mock.pstmn.io/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http_client.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }

}