import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpUtility {
  static Future<HttpResponse?> getRequest({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _handleResponse(response);
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  static Future<HttpResponse?> postRequest(
      {required String url, required dynamic data}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  static HttpResponse _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody =
        response.body == '' ? null : json.decode(response.body);

    if (!(statusCode >= 200 && statusCode < 300)) {
      // Request failed
      print('HTTP request error. Status code: $statusCode');
      print('Response body: $responseBody');
    }

    return HttpResponse(status: statusCode, body: responseBody);
  }
}

class HttpResponse {
  final int status;
  final dynamic body;

  HttpResponse({required this.status, required this.body});
}
