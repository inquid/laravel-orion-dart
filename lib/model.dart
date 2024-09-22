import 'query_builder.dart';

abstract class Model {
  late Map<String, dynamic> attributes;
  late String resource;

  Model({required this.attributes, required this.resource});

  get title => attributes['title'];

  // This method should be implemented by all subclasses to convert JSON to the model instance
  Model fromJson(Map<String, dynamic> json);

  String $resource() {
    return resource;
  }

  // Save the model (either create or update)
  Future<void> $save() async {
    if (attributes['id'] == null) {
      // No ID means we need to create the model
      final newModelData = await QueryBuilder(this).store(attributes);
      attributes = newModelData.attributes;
    } else {
      // ID exists, so we update the model
      final updatedModelData =
          await QueryBuilder(this).update(attributes['id'], attributes);
      attributes = updatedModelData.attributes;
    }
  }

  // Delete the model instance
  Future<void> $destroy() async {
    if (attributes['id'] != null) {
      await QueryBuilder(this).delete(attributes['id']);
    } else {
      throw Exception('Cannot delete a model without an ID');
    }
  }
}
