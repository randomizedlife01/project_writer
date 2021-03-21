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

/** This is an auto generated class representing the IdeaMemo type in your schema. */
@immutable
class IdeaMemo extends Model {
  static const classType = const IdeaMemoType();
  final String id;
  final String memo;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const IdeaMemo._internal({@required this.id, this.memo});

  factory IdeaMemo({String id, String memo}) {
    return IdeaMemo._internal(id: id == null ? UUID.getUUID() : id, memo: memo);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IdeaMemo && id == other.id && memo == other.memo;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("IdeaMemo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("memo=" + "$memo");
    buffer.write("}");

    return buffer.toString();
  }

  IdeaMemo copyWith({String id, String memo}) {
    return IdeaMemo(id: id ?? this.id, memo: memo ?? this.memo);
  }

  IdeaMemo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        memo = json['memo'];

  Map<String, dynamic> toJson() => {'id': id, 'memo': memo};

  static final QueryField ID = QueryField(fieldName: "ideaMemo.id");
  static final QueryField MEMO = QueryField(fieldName: "memo");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "IdeaMemo";
    modelSchemaDefinition.pluralName = "IdeaMemos";

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
        key: IdeaMemo.MEMO,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class IdeaMemoType extends ModelType<IdeaMemo> {
  const IdeaMemoType();

  @override
  IdeaMemo fromJson(Map<String, dynamic> jsonData) {
    return IdeaMemo.fromJson(jsonData);
  }
}
