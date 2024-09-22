import 'dart:convert';
import 'http_client.dart';
import 'orion.dart';
import 'model.dart';

class QueryBuilder<T extends Model> {
  final T model;
  late HttpClient httpClient;

  QueryBuilder(this.model) {
    httpClient = HttpClient(Orion.baseUrl, Orion.client);
  }

  // Retrieve a list of models (paginated or non-paginated)
  Future<List<T>> get() async {
    final response = await httpClient.get(Orion.getFullUrl(model.$resource()));
    final jsonResponse = jsonDecode(response.body);

    // Return the data part of the response and map it to models
    if (jsonResponse.containsKey('data')) {
      return List<T>.from(
          jsonResponse['data'].map((item) => model.fromJson(item)));
    } else {
      throw Exception('Data field not found in response');
    }
  }

  // Retrieve a single model by ID
  Future<Model> find(int id) async {
    final response =
        await httpClient.get(Orion.getFullUrl('${model.$resource()}/$id'));
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse.containsKey('data')) {
      return model.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Data field not found in response');
    }
  }

  // Create a new model
  Future<Model> store(Map<String, dynamic> data) async {
    final response =
        await httpClient.post(Orion.getFullUrl(model.$resource()), data: data);
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse.containsKey('data')) {
      return model.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Data field not found in response');
    }
  }

  // Update an existing model by ID
  Future<Model> update(int id, Map<String, dynamic> data) async {
    final response = await httpClient
        .put(Orion.getFullUrl('${model.$resource()}/$id'), data: data);
    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse.containsKey('data')) {
      return model.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Data field not found in response');
    }
  }

  // Delete a model by ID
  Future<void> delete(int id) async {
    await httpClient.delete(Orion.getFullUrl('${model.$resource()}/$id'));
  }
}
