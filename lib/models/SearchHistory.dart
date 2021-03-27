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

/** This is an auto generated class representing the SearchHistory type in your schema. */
@immutable
class SearchHistory extends Model {
  static const classType = const SearchHistoryType();
  final String id;
  final String searchHistory;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const SearchHistory._internal({@required this.id, this.searchHistory});

  factory SearchHistory({String id, String searchHistory}) {
    return SearchHistory._internal(
        id: id == null ? UUID.getUUID() : id, searchHistory: searchHistory);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchHistory &&
        id == other.id &&
        searchHistory == other.searchHistory;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("SearchHistory {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("searchHistory=" + "$searchHistory");
    buffer.write("}");

    return buffer.toString();
  }

  SearchHistory copyWith({String id, String searchHistory}) {
    return SearchHistory(
        id: id ?? this.id, searchHistory: searchHistory ?? this.searchHistory);
  }

  SearchHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        searchHistory = json['searchHistory'];

  Map<String, dynamic> toJson() => {'id': id, 'searchHistory': searchHistory};

  static final QueryField ID = QueryField(fieldName: "searchHistory.id");
  static final QueryField SEARCHHISTORY =
      QueryField(fieldName: "searchHistory");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SearchHistory";
    modelSchemaDefinition.pluralName = "SearchHistories";

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
        key: SearchHistory.SEARCHHISTORY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class SearchHistoryType extends ModelType<SearchHistory> {
  const SearchHistoryType();

  @override
  SearchHistory fromJson(Map<String, dynamic> jsonData) {
    return SearchHistory.fromJson(jsonData);
  }
}
