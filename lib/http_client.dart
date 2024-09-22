import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orion_sdk_dart/orion.dart';

class HttpClient {
  final String baseUrl;
  final http.Client client;

  HttpClient(this.baseUrl, this.client);

  Future<http.Response> get(String url, {Map<String, dynamic>? params}) async {
    Uri uri = Uri.parse(url).replace(queryParameters: params);
    return await client.get(uri, headers: {
      'Authorization': Orion.token != null ? 'Bearer ${Orion.token}' : '',
    });
  }

  Future<http.Response> post(String url, {Map<String, dynamic>? data}) async {
    return await client.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'Authorization': Orion.token != null ? 'Bearer ${Orion.token}' : '',
    });
  }

  Future<http.Response> put(String url, {Map<String, dynamic>? data}) async {
    return await client.put(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
      'Authorization': Orion.token != null ? 'Bearer ${Orion.token}' : '',
    });
  }

  Future<http.Response> delete(String url) async {
    return await client.delete(Uri.parse(url), headers: {
      'Authorization': Orion.token != null ? 'Bearer ${Orion.token}' : '',
    });
  }
}
