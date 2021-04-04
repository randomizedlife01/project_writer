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

/** This is an auto generated class representing the MyLifeStory type in your schema. */
@immutable
class MyLifeStory extends Model {
  static const classType = const MyLifeStoryType();
  final String id;
  final String lifeMemo;
  final TemporalDate myLifeDate;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MyLifeStory._internal(
      {@required this.id, this.lifeMemo, @required this.myLifeDate});

  factory MyLifeStory(
      {String id, String lifeMemo, @required TemporalDate myLifeDate}) {
    return MyLifeStory._internal(
        id: id == null ? UUID.getUUID() : id,
        lifeMemo: lifeMemo,
        myLifeDate: myLifeDate);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyLifeStory &&
        id == other.id &&
        lifeMemo == other.lifeMemo &&
        myLifeDate == other.myLifeDate;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MyLifeStory {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("lifeMemo=" + "$lifeMemo" + ", ");
    buffer.write(
        "myLifeDate=" + (myLifeDate != null ? myLifeDate.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  MyLifeStory copyWith({String id, String lifeMemo, TemporalDate myLifeDate}) {
    return MyLifeStory(
        id: id ?? this.id,
        lifeMemo: lifeMemo ?? this.lifeMemo,
        myLifeDate: myLifeDate ?? this.myLifeDate);
  }

  MyLifeStory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lifeMemo = json['lifeMemo'],
        myLifeDate = json['myLifeDate'] != null
            ? TemporalDate.fromString(json['myLifeDate'])
            : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'lifeMemo': lifeMemo, 'myLifeDate': myLifeDate?.format()};

  static final QueryField ID = QueryField(fieldName: "myLifeStory.id");
  static final QueryField LIFEMEMO = QueryField(fieldName: "lifeMemo");
  static final QueryField MYLIFEDATE = QueryField(fieldName: "myLifeDate");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MyLifeStory";
    modelSchemaDefinition.pluralName = "MyLifeStories";

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
        key: MyLifeStory.LIFEMEMO,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeStory.MYLIFEDATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));
  });
}

class MyLifeStoryType extends ModelType<MyLifeStory> {
  const MyLifeStoryType();

  @override
  MyLifeStory fromJson(Map<String, dynamic> jsonData) {
    return MyLifeStory.fromJson(jsonData);
  }
}
