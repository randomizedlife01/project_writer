import 'package:flutter/material.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

//TODO: 스토리 페이지 진행. 우선 시공간과 요약 문장부터.

class StoryPage extends StatelessWidget {
  final String documentId;
  final storySummaryController = StorySummaryController.to;

  StoryPage({Key key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    storySummaryController.readStorySummaries(getDocumentId: documentId);
    return Scaffold();
  }
}
