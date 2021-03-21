/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the SearchTags type in your schema. */
@immutable
class SearchTags extends Model {
  static const classType = const SearchTagsType();
  final String id;
  final String tag;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const SearchTags._internal({@required this.id, this.tag});

  factory SearchTags({String id, String tag}) {
    return SearchTags._internal(id: id == null ? UUID.getUUID() : id, tag: tag);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchTags && id == other.id && tag == other.tag;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("SearchTags {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("tag=" + "$tag");
    buffer.write("}");

    return buffer.toString();
  }

  SearchTags copyWith({String id, String tag}) {
    return SearchTags(id: id ?? this.id, tag: tag ?? this.tag);
  }

  SearchTags.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tag = json['tag'];

  Map<String, dynamic> toJson() => {'id': id, 'tag': tag};

  static final QueryField ID = QueryField(fieldName: "searchTags.id");
  static final QueryField TAG = QueryField(fieldName: "tag");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SearchTags";
    modelSchemaDefinition.pluralName = "SearchTags";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: SearchTags.TAG,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class SearchTagsType extends ModelType<SearchTags> {
  const SearchTagsType();

  @override
  SearchTags fromJson(Map<String, dynamic> jsonData) {
    return SearchTags.fromJson(jsonData);
  }
}
