import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/document/intro_page/intro_page.dart';

class StoryPage extends StatelessWidget {
  final String documentId;

  const StoryPage({Key key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(documentId);
    return Scaffold();
  }
}
