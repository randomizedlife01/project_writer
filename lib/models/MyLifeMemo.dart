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

/** This is an auto generated class representing the MyLifeMemo type in your schema. */
@immutable
class MyLifeMemo extends Model {
  static const classType = const MyLifeMemoType();
  final String id;
  final String lifeMemo;
  final TemporalDate myLifeDate;
  final String documentID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MyLifeMemo._internal(
      {@required this.id,
      this.lifeMemo,
      @required this.myLifeDate,
      this.documentID});

  factory MyLifeMemo(
      {String id,
      String lifeMemo,
      @required TemporalDate myLifeDate,
      String documentID}) {
    return MyLifeMemo._internal(
        id: id == null ? UUID.getUUID() : id,
        lifeMemo: lifeMemo,
        myLifeDate: myLifeDate,
        documentID: documentID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyLifeMemo &&
        id == other.id &&
        lifeMemo == other.lifeMemo &&
        myLifeDate == other.myLifeDate &&
        documentID == other.documentID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MyLifeMemo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("lifeMemo=" + "$lifeMemo" + ", ");
    buffer.write("myLifeDate=" +
        (myLifeDate != null ? myLifeDate.format() : "null") +
        ", ");
    buffer.write("documentID=" + "$documentID");
    buffer.write("}");

    return buffer.toString();
  }

  MyLifeMemo copyWith(
      {String id,
      String lifeMemo,
      TemporalDate myLifeDate,
      String documentID}) {
    return MyLifeMemo(
        id: id ?? this.id,
        lifeMemo: lifeMemo ?? this.lifeMemo,
        myLifeDate: myLifeDate ?? this.myLifeDate,
        documentID: documentID ?? this.documentID);
  }

  MyLifeMemo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lifeMemo = json['lifeMemo'],
        myLifeDate = json['myLifeDate'] != null
            ? TemporalDate.fromString(json['myLifeDate'])
            : null,
        documentID = json['documentID'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'lifeMemo': lifeMemo,
        'myLifeDate': myLifeDate?.format(),
        'documentID': documentID
      };

  static final QueryField ID = QueryField(fieldName: "myLifeMemo.id");
  static final QueryField LIFEMEMO = QueryField(fieldName: "lifeMemo");
  static final QueryField MYLIFEDATE = QueryField(fieldName: "myLifeDate");
  static final QueryField DOCUMENTID = QueryField(fieldName: "documentID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MyLifeMemo";
    modelSchemaDefinition.pluralName = "MyLifeMemos";

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
        key: MyLifeMemo.LIFEMEMO,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeMemo.MYLIFEDATE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeMemo.DOCUMENTID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class MyLifeMemoType extends ModelType<MyLifeMemo> {
  const MyLifeMemoType();

  @override
  MyLifeMemo fromJson(Map<String, dynamic> jsonData) {
    return MyLifeMemo.fromJson(jsonData);
  }
}
