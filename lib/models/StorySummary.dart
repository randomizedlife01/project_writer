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

/** This is an auto generated class representing the StorySummary type in your schema. */
@immutable
class StorySummary extends Model {
  static const classType = const _StorySummaryModelType();
  final String id;
  final String storySummary;
  final String documentID;
  final String space;
  final String time;
  final String weather;
  final String storyDetail;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const StorySummary._internal(
      {@required this.id,
      this.storySummary,
      this.documentID,
      this.space,
      this.time,
      this.weather,
      this.storyDetail});

  factory StorySummary(
      {String id,
      String storySummary,
      String documentID,
      String space,
      String time,
      String weather,
      String storyDetail}) {
    return StorySummary._internal(
        id: id == null ? UUID.getUUID() : id,
        storySummary: storySummary,
        documentID: documentID,
        space: space,
        time: time,
        weather: weather,
        storyDetail: storyDetail);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StorySummary &&
        id == other.id &&
        storySummary == other.storySummary &&
        documentID == other.documentID &&
        space == other.space &&
        time == other.time &&
        weather == other.weather &&
        storyDetail == other.storyDetail;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("StorySummary {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("storySummary=" + "$storySummary" + ", ");
    buffer.write("documentID=" + "$documentID" + ", ");
    buffer.write("space=" + "$space" + ", ");
    buffer.write("time=" + "$time" + ", ");
    buffer.write("weather=" + "$weather" + ", ");
    buffer.write("storyDetail=" + "$storyDetail");
    buffer.write("}");

    return buffer.toString();
  }

  StorySummary copyWith(
      {String id,
      String storySummary,
      String documentID,
      String space,
      String time,
      String weather,
      String storyDetail}) {
    return StorySummary(
        id: id ?? this.id,
        storySummary: storySummary ?? this.storySummary,
        documentID: documentID ?? this.documentID,
        space: space ?? this.space,
        time: time ?? this.time,
        weather: weather ?? this.weather,
        storyDetail: storyDetail ?? this.storyDetail);
  }

  StorySummary.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        storySummary = json['storySummary'],
        documentID = json['documentID'],
        space = json['space'],
        time = json['time'],
        weather = json['weather'],
        storyDetail = json['storyDetail'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'storySummary': storySummary,
        'documentID': documentID,
        'space': space,
        'time': time,
        'weather': weather,
        'storyDetail': storyDetail
      };

  static final QueryField ID = QueryField(fieldName: "storySummary.id");
  static final QueryField STORYSUMMARY = QueryField(fieldName: "storySummary");
  static final QueryField DOCUMENTID = QueryField(fieldName: "documentID");
  static final QueryField SPACE = QueryField(fieldName: "space");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField WEATHER = QueryField(fieldName: "weather");
  static final QueryField STORYDETAIL = QueryField(fieldName: "storyDetail");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "StorySummary";
    modelSchemaDefinition.pluralName = "StorySummaries";

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
        key: StorySummary.STORYSUMMARY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: StorySummary.DOCUMENTID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: StorySummary.SPACE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: StorySummary.TIME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: StorySummary.WEATHER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: StorySummary.STORYDETAIL,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _StorySummaryModelType extends ModelType<StorySummary> {
  const _StorySummaryModelType();

  @override
  StorySummary fromJson(Map<String, dynamic> jsonData) {
    return StorySummary.fromJson(jsonData);
  }
}
