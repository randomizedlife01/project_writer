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

/** This is an auto generated class representing the Document type in your schema. */
@immutable
class Document extends Model {
  static const classType = const _DocumentModelType();
  final String id;
  final String docName;
  final String docDesc;
  final List<StorySummary> StorySummaries;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Document._internal(
      {@required this.id, this.docName, this.docDesc, this.StorySummaries});

  factory Document(
      {String id,
      String docName,
      String docDesc,
      List<StorySummary> StorySummaries}) {
    return Document._internal(
        id: id == null ? UUID.getUUID() : id,
        docName: docName,
        docDesc: docDesc,
        StorySummaries: StorySummaries != null
            ? List.unmodifiable(StorySummaries)
            : StorySummaries);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Document &&
        id == other.id &&
        docName == other.docName &&
        docDesc == other.docDesc &&
        DeepCollectionEquality().equals(StorySummaries, other.StorySummaries);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Document {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("docName=" + "$docName" + ", ");
    buffer.write("docDesc=" + "$docDesc");
    buffer.write("}");

    return buffer.toString();
  }

  Document copyWith(
      {String id,
      String docName,
      String docDesc,
      List<StorySummary> StorySummaries}) {
    return Document(
        id: id ?? this.id,
        docName: docName ?? this.docName,
        docDesc: docDesc ?? this.docDesc,
        StorySummaries: StorySummaries ?? this.StorySummaries);
  }

  Document.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        docName = json['docName'],
        docDesc = json['docDesc'],
        StorySummaries = json['StorySummaries'] is List
            ? (json['StorySummaries'] as List)
                .map((e) =>
                    StorySummary.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'docName': docName,
        'docDesc': docDesc,
        'StorySummaries': StorySummaries?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "document.id");
  static final QueryField DOCNAME = QueryField(fieldName: "docName");
  static final QueryField DOCDESC = QueryField(fieldName: "docDesc");
  static final QueryField STORYSUMMARIES = QueryField(
      fieldName: "StorySummaries",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (StorySummary).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Document";
    modelSchemaDefinition.pluralName = "Documents";

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
        key: Document.DOCNAME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Document.DOCDESC,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Document.STORYSUMMARIES,
        isRequired: false,
        ofModelName: (StorySummary).toString(),
        associatedKey: StorySummary.DOCUMENTID));
  });
}

class _DocumentModelType extends ModelType<Document> {
  const _DocumentModelType();

  @override
  Document fromJson(Map<String, dynamic> jsonData) {
    return Document.fromJson(jsonData);
  }
}
