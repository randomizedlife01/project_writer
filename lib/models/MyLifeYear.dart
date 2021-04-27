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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the MyLifeYear type in your schema. */
@immutable
class MyLifeYear extends Model {
  static const classType = const _MyLifeYearModelType();
  final String id;
  final String year;
  final List<MyLifeSeason> MyLifeSeasons;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MyLifeYear._internal(
      {@required this.id, this.year, this.MyLifeSeasons});

  factory MyLifeYear(
      {String id, String year, List<MyLifeSeason> MyLifeSeasons}) {
    return MyLifeYear._internal(
        id: id == null ? UUID.getUUID() : id,
        year: year,
        MyLifeSeasons: MyLifeSeasons != null
            ? List.unmodifiable(MyLifeSeasons)
            : MyLifeSeasons);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyLifeYear &&
        id == other.id &&
        year == other.year &&
        DeepCollectionEquality().equals(MyLifeSeasons, other.MyLifeSeasons);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MyLifeYear {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("year=" + "$year");
    buffer.write("}");

    return buffer.toString();
  }

  MyLifeYear copyWith(
      {String id, String year, List<MyLifeSeason> MyLifeSeasons}) {
    return MyLifeYear(
        id: id ?? this.id,
        year: year ?? this.year,
        MyLifeSeasons: MyLifeSeasons ?? this.MyLifeSeasons);
  }

  MyLifeYear.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        year = json['year'],
        MyLifeSeasons = json['MyLifeSeasons'] is List
            ? (json['MyLifeSeasons'] as List)
                .map((e) =>
                    MyLifeSeason.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'year': year,
        'MyLifeSeasons': MyLifeSeasons?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "myLifeYear.id");
  static final QueryField YEAR = QueryField(fieldName: "year");
  static final QueryField MYLIFESEASONS = QueryField(
      fieldName: "MyLifeSeasons",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (MyLifeSeason).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MyLifeYear";
    modelSchemaDefinition.pluralName = "MyLifeYears";

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
        key: MyLifeYear.YEAR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: MyLifeYear.MYLIFESEASONS,
        isRequired: false,
        ofModelName: (MyLifeSeason).toString(),
        associatedKey: MyLifeSeason.MYLIFEYEARID));
  });
}

class _MyLifeYearModelType extends ModelType<MyLifeYear> {
  const _MyLifeYearModelType();

  @override
  MyLifeYear fromJson(Map<String, dynamic> jsonData) {
    return MyLifeYear.fromJson(jsonData);
  }
}
