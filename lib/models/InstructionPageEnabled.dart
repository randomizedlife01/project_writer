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

/** This is an auto generated class representing the InstructionPageEnabled type in your schema. */
@immutable
class InstructionPageEnabled extends Model {
  static const classType = const _InstructionPageEnabledModelType();
  final String id;
  final bool isEnabled;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const InstructionPageEnabled._internal({@required this.id, this.isEnabled});

  factory InstructionPageEnabled({String id, bool isEnabled}) {
    return InstructionPageEnabled._internal(
        id: id == null ? UUID.getUUID() : id, isEnabled: isEnabled);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InstructionPageEnabled &&
        id == other.id &&
        isEnabled == other.isEnabled;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("InstructionPageEnabled {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write(
        "isEnabled=" + (isEnabled != null ? isEnabled.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  InstructionPageEnabled copyWith({String id, bool isEnabled}) {
    return InstructionPageEnabled(
        id: id ?? this.id, isEnabled: isEnabled ?? this.isEnabled);
  }

  InstructionPageEnabled.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isEnabled = json['isEnabled'];

  Map<String, dynamic> toJson() => {'id': id, 'isEnabled': isEnabled};

  static final QueryField ID =
      QueryField(fieldName: "instructionPageEnabled.id");
  static final QueryField ISENABLED = QueryField(fieldName: "isEnabled");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "InstructionPageEnabled";
    modelSchemaDefinition.pluralName = "InstructionPageEnableds";

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
        key: InstructionPageEnabled.ISENABLED,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));
  });
}

class _InstructionPageEnabledModelType
    extends ModelType<InstructionPageEnabled> {
  const _InstructionPageEnabledModelType();

  @override
  InstructionPageEnabled fromJson(Map<String, dynamic> jsonData) {
    return InstructionPageEnabled.fromJson(jsonData);
  }
}
