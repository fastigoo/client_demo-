

import 'package:learning/features/post/domain/entities/post_entity.dart';

class PostModel extends PostEntity{

  PostModel({
    required super.title,
    required super.body,
    required super.id,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
    };
  }
}