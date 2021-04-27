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

/** This is an auto generated class representing the MyLifeSeason type in your schema. */
@immutable
class MyLifeSeason extends Model {
  static const classType = const _MyLifeSeasonModelType();
  final String id;
  final String season;
  final String mylifeyearID;
  final List<MyLifeDetail> MyLifeDetails;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const MyLifeSeason._internal(
      {@required this.id, this.season, this.mylifeyearID, this.MyLifeDetails});

  factory MyLifeSeason(
      {String id,
      String season,
      String mylifeyearID,
      List<MyLifeDetail> MyLifeDetails}) {
    return MyLifeSeason._internal(
        id: id == null ? UUID.getUUID() : id,
        season: season,
        mylifeyearID: mylifeyearID,
        MyLifeDetails: MyLifeDetails != null
            ? List.unmodifiable(MyLifeDetails)
            : MyLifeDetails);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyLifeSeason &&
        id == other.id &&
        season == other.season &&
        mylifeyearID == other.mylifeyearID &&
        DeepCollectionEquality().equals(MyLifeDetails, other.MyLifeDetails);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MyLifeSeason {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("season=" + "$season" + ", ");
    buffer.write("mylifeyearID=" + "$mylifeyearID");
    buffer.write("}");

    return buffer.toString();
  }

  MyLifeSeason copyWith(
      {String id,
      String season,
      String mylifeyearID,
      List<MyLifeDetail> MyLifeDetails}) {
    return MyLifeSeason(
        id: id ?? this.id,
        season: season ?? this.season,
        mylifeyearID: mylifeyearID ?? this.mylifeyearID,
        MyLifeDetails: MyLifeDetails ?? this.MyLifeDetails);
  }

  MyLifeSeason.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        season = json['season'],
        mylifeyearID = json['mylifeyearID'],
        MyLifeDetails = json['MyLifeDetails'] is List
            ? (json['MyLifeDetails'] as List)
                .map((e) =>
                    MyLifeDetail.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'season': season,
        'mylifeyearID': mylifeyearID,
        'MyLifeDetails': MyLifeDetails?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "myLifeSeason.id");
  static final QueryField SEASON = QueryField(fieldName: "season");
  static final QueryField MYLIFEYEARID = QueryField(fieldName: "mylifeyearID");
  static final QueryField MYLIFEDETAILS = QueryField(
      fieldName: "MyLifeDetails",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (MyLifeDetail).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MyLifeSeason";
    modelSchemaDefinition.pluralName = "MyLifeSeasons";

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
        key: MyLifeSeason.SEASON,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: MyLifeSeason.MYLIFEYEARID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: MyLifeSeason.MYLIFEDETAILS,
        isRequired: false,
        ofModelName: (MyLifeDetail).toString(),
        associatedKey: MyLifeDetail.MYLIFESEASONID));
  });
}

class _MyLifeSeasonModelType extends ModelType<MyLifeSeason> {
  const _MyLifeSeasonModelType();

  @override
  MyLifeSeason fromJson(Map<String, dynamic> jsonData) {
    return MyLifeSeason.fromJson(jsonData);
  }
}
