import 'model.dart';
import 'query_builder.dart';

class Post extends Model {
  String? title;
  String? body;

  Post({Map<String, dynamic>? attributes})
      : super(attributes: attributes ?? {}, resource: 'posts') {
    title = attributes?['title'];
    body = attributes?['body'];
  }

  @override
  Post fromJson(Map<String, dynamic> json) {
    return Post(attributes: {
      'id': json['id'],
      'title': json['title'],
      'body': json['body'],
      'created_at': json['created_at'],
      'updated_at': json['updated_at'],
      'deleted_at': json['deleted_at'],
      'created_by': json['created_by'],
      'updated_by': json['updated_by'],
      'deleted_by': json['deleted_by'],
    });
  }

  // Static query method to return a QueryBuilder for Post
  static QueryBuilder<Post> query(Post post) {
    return QueryBuilder(post);
  }
}
