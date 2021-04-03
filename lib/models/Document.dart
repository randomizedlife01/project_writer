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
  static const classType = const DocumentType();
  final String id;
  final String docName;
  final String docDesc;
  final List<IdeaMemo> IdeaMemos;
  final List<MyLifeMemo> MyLifeMemos;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Document._internal(
      {@required this.id,
      this.docName,
      this.docDesc,
      this.IdeaMemos,
      this.MyLifeMemos});

  factory Document(
      {String id,
      String docName,
      String docDesc,
      List<IdeaMemo> IdeaMemos,
      List<MyLifeMemo> MyLifeMemos}) {
    return Document._internal(
        id: id == null ? UUID.getUUID() : id,
        docName: docName,
        docDesc: docDesc,
        IdeaMemos: IdeaMemos != null ? List.unmodifiable(IdeaMemos) : IdeaMemos,
        MyLifeMemos:
            MyLifeMemos != null ? List.unmodifiable(MyLifeMemos) : MyLifeMemos);
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
        DeepCollectionEquality().equals(IdeaMemos, other.IdeaMemos) &&
        DeepCollectionEquality().equals(MyLifeMemos, other.MyLifeMemos);
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
      List<IdeaMemo> IdeaMemos,
      List<MyLifeMemo> MyLifeMemos}) {
    return Document(
        id: id ?? this.id,
        docName: docName ?? this.docName,
        docDesc: docDesc ?? this.docDesc,
        IdeaMemos: IdeaMemos ?? this.IdeaMemos,
        MyLifeMemos: MyLifeMemos ?? this.MyLifeMemos);
  }

  Document.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        docName = json['docName'],
        docDesc = json['docDesc'],
        IdeaMemos = json['IdeaMemos'] is List
            ? (json['IdeaMemos'] as List)
                .map((e) => IdeaMemo.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        MyLifeMemos = json['MyLifeMemos'] is List
            ? (json['MyLifeMemos'] as List)
                .map((e) =>
                    MyLifeMemo.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'docName': docName,
        'docDesc': docDesc,
        'IdeaMemos': IdeaMemos?.map((e) => e?.toJson())?.toList(),
        'MyLifeMemos': MyLifeMemos?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "document.id");
  static final QueryField DOCNAME = QueryField(fieldName: "docName");
  static final QueryField DOCDESC = QueryField(fieldName: "docDesc");
  static final QueryField IDEAMEMOS = QueryField(
      fieldName: "IdeaMemos",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (IdeaMemo).toString()));
  static final QueryField MYLIFEMEMOS = QueryField(
      fieldName: "MyLifeMemos",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (MyLifeMemo).toString()));
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
        key: Document.IDEAMEMOS,
        isRequired: false,
        ofModelName: (IdeaMemo).toString(),
        associatedKey: IdeaMemo.DOCUMENTID));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Document.MYLIFEMEMOS,
        isRequired: false,
        ofModelName: (MyLifeMemo).toString(),
        associatedKey: MyLifeMemo.DOCUMENTID));
  });
}

class DocumentType extends ModelType<Document> {
  const DocumentType();

  @override
  Document fromJson(Map<String, dynamic> jsonData) {
    return Document.fromJson(jsonData);
  }
}
