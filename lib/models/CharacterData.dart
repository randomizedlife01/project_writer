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

/** This is an auto generated class representing the CharacterData type in your schema. */
@immutable
class CharacterData extends Model {
  static const classType = const _CharacterDataModelType();
  final String id;
  final String motivation;
  final int tendency;
  final String description;
  final String gender;
  final String age;
  final String name;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const CharacterData._internal(
      {@required this.id,
      this.motivation,
      this.tendency,
      this.description,
      this.gender,
      this.age,
      this.name});

  factory CharacterData(
      {String id,
      String motivation,
      int tendency,
      String description,
      String gender,
      String age,
      String name}) {
    return CharacterData._internal(
        id: id == null ? UUID.getUUID() : id,
        motivation: motivation,
        tendency: tendency,
        description: description,
        gender: gender,
        age: age,
        name: name);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CharacterData &&
        id == other.id &&
        motivation == other.motivation &&
        tendency == other.tendency &&
        description == other.description &&
        gender == other.gender &&
        age == other.age &&
        name == other.name;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("CharacterData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("motivation=" + "$motivation" + ", ");
    buffer.write(
        "tendency=" + (tendency != null ? tendency.toString() : "null") + ", ");
    buffer.write("description=" + "$description" + ", ");
    buffer.write("gender=" + "$gender" + ", ");
    buffer.write("age=" + "$age" + ", ");
    buffer.write("name=" + "$name");
    buffer.write("}");

    return buffer.toString();
  }

  CharacterData copyWith(
      {String id,
      String motivation,
      int tendency,
      String description,
      String gender,
      String age,
      String name}) {
    return CharacterData(
        id: id ?? this.id,
        motivation: motivation ?? this.motivation,
        tendency: tendency ?? this.tendency,
        description: description ?? this.description,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        name: name ?? this.name);
  }

  CharacterData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        motivation = json['motivation'],
        tendency = json['tendency'],
        description = json['description'],
        gender = json['gender'],
        age = json['age'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'motivation': motivation,
        'tendency': tendency,
        'description': description,
        'gender': gender,
        'age': age,
        'name': name
      };

  static final QueryField ID = QueryField(fieldName: "characterData.id");
  static final QueryField MOTIVATION = QueryField(fieldName: "motivation");
  static final QueryField TENDENCY = QueryField(fieldName: "tendency");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField AGE = QueryField(fieldName: "age");
  static final QueryField NAME = QueryField(fieldName: "name");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CharacterData";
    modelSchemaDefinition.pluralName = "CharacterData";

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
        key: CharacterData.MOTIVATION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CharacterData.TENDENCY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CharacterData.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CharacterData.GENDER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CharacterData.AGE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: CharacterData.NAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _CharacterDataModelType extends ModelType<CharacterData> {
  const _CharacterDataModelType();

  @override
  CharacterData fromJson(Map<String, dynamic> jsonData) {
    return CharacterData.fromJson(jsonData);
  }
}
