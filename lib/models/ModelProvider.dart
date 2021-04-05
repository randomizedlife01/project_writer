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
import 'Document.dart';
import 'IdeaMemo.dart';
import 'MyLifeStory.dart';
import 'SearchHistory.dart';
import 'StorySummary.dart';

export 'Document.dart';
export 'IdeaMemo.dart';
export 'MyLifeStory.dart';
export 'SearchHistory.dart';
export 'StorySummary.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "d77f32a19775254de475d886ae3adaf2";
  @override
  List<ModelSchema> modelSchemas = [Document.schema, IdeaMemo.schema, MyLifeStory.schema, SearchHistory.schema, StorySummary.schema];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Document":
        {
          return Document.classType;
        }
        break;
      case "IdeaMemo":
        {
          return IdeaMemo.classType;
        }
        break;
      case "MyLifeStory":
        {
          return MyLifeStory.classType;
        }
        break;
      case "SearchHistory":
        {
          return SearchHistory.classType;
        }
        break;
      case "StorySummary":
        {
          return StorySummary.classType;
        }
        break;
      default:
        {
          throw Exception("Failed to find model in model provider for model name: " + modelName);
        }
    }
  }
}
