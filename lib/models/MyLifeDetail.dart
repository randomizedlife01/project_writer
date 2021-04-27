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

/** This is an auto generated class representing the MyLifeDetail type in your schema. */
@immutable
class MyLifeDetail extends Model {
  static const classType = const _MyLifeDetailModelType();
  final String id;
  final String lifeMemo;
  final String date;
  final String month;
  final String mylifeseasonID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MyLifeDetail._internal(
      {@required this.id,
      @required this.lifeMemo,
      this.date,
      this.month,
      this.mylifeseasonID});

  factory MyLifeDetail(
      {String id,
      @required String lifeMemo,
      String date,
      String month,
      String mylifeseasonID}) {
    return MyLifeDetail._internal(
        id: id == null ? UUID.getUUID() : id,
        lifeMemo: lifeMemo,
        date: date,
        month: month,
        mylifeseasonID: mylifeseasonID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyLifeDetail &&
        id == other.id &&
        lifeMemo == other.lifeMemo &&
        date == other.date &&
        month == other.month &&
        mylifeseasonID == other.mylifeseasonID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MyLifeDetail {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("lifeMemo=" + "$lifeMemo" + ", ");
    buffer.write("date=" + "$date" + ", ");
    buffer.write("month=" + "$month" + ", ");
    buffer.write("mylifeseasonID=" + "$mylifeseasonID");
    buffer.write("}");

    return buffer.toString();
  }

  MyLifeDetail copyWith(
      {String id,
      String lifeMemo,
      String date,
      String month,
      String mylifeseasonID}) {
    return MyLifeDetail(
        id: id ?? this.id,
        lifeMemo: lifeMemo ?? this.lifeMemo,
        date: date ?? this.date,
        month: month ?? this.month,
        mylifeseasonID: mylifeseasonID ?? this.mylifeseasonID);
  }

  MyLifeDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lifeMemo = json['lifeMemo'],
        date = json['date'],
        month = json['month'],
        mylifeseasonID = json['mylifeseasonID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lifeMemo': lifeMemo,
        'date': date,
        'month': month,
        'mylifeseasonID': mylifeseasonID
      };

  static final QueryField ID = QueryField(fieldName: "myLifeDetail.id");
  static final QueryField LIFEMEMO = QueryField(fieldName: "lifeMemo");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField MONTH = QueryField(fieldName: "month");
  static final QueryField MYLIFESEASONID =
      QueryField(fieldName: "mylifeseasonID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MyLifeDetail";
    modelSchemaDefinition.pluralName = "MyLifeDetails";

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
        key: MyLifeDetail.LIFEMEMO,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeDetail.DATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeDetail.MONTH,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeDetail.MYLIFESEASONID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _MyLifeDetailModelType extends ModelType<MyLifeDetail> {
  const _MyLifeDetailModelType();

  @override
  MyLifeDetail fromJson(Map<String, dynamic> jsonData) {
    return MyLifeDetail.fromJson(jsonData);
  }
}
