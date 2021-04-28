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
  static const classType = const _MyLifeStoryModelType();
  final String id;
  final String lifeMemo;
  final String year;
  final String season;
  final String date;
  final String month;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MyLifeStory._internal(
      {@required this.id,
      @required this.lifeMemo,
      this.year,
      this.season,
      this.date,
      this.month});

  factory MyLifeStory(
      {String id,
      @required String lifeMemo,
      String year,
      String season,
      String date,
      String month}) {
    return MyLifeStory._internal(
        id: id == null ? UUID.getUUID() : id,
        lifeMemo: lifeMemo,
        year: year,
        season: season,
        date: date,
        month: month);
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
        year == other.year &&
        season == other.season &&
        date == other.date &&
        month == other.month;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MyLifeStory {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("lifeMemo=" + "$lifeMemo" + ", ");
    buffer.write("year=" + "$year" + ", ");
    buffer.write("season=" + "$season" + ", ");
    buffer.write("date=" + "$date" + ", ");
    buffer.write("month=" + "$month");
    buffer.write("}");

    return buffer.toString();
  }

  MyLifeStory copyWith(
      {String id,
      String lifeMemo,
      String year,
      String season,
      String date,
      String month}) {
    return MyLifeStory(
        id: id ?? this.id,
        lifeMemo: lifeMemo ?? this.lifeMemo,
        year: year ?? this.year,
        season: season ?? this.season,
        date: date ?? this.date,
        month: month ?? this.month);
  }

  MyLifeStory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lifeMemo = json['lifeMemo'],
        year = json['year'],
        season = json['season'],
        date = json['date'],
        month = json['month'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lifeMemo': lifeMemo,
        'year': year,
        'season': season,
        'date': date,
        'month': month
      };

  static final QueryField ID = QueryField(fieldName: "myLifeStory.id");
  static final QueryField LIFEMEMO = QueryField(fieldName: "lifeMemo");
  static final QueryField YEAR = QueryField(fieldName: "year");
  static final QueryField SEASON = QueryField(fieldName: "season");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField MONTH = QueryField(fieldName: "month");
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
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeStory.YEAR,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeStory.SEASON,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeStory.DATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeStory.MONTH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _MyLifeStoryModelType extends ModelType<MyLifeStory> {
  const _MyLifeStoryModelType();

  @override
  MyLifeStory fromJson(Map<String, dynamic> jsonData) {
    return MyLifeStory.fromJson(jsonData);
  }
}
