import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_parts.dart';
import 'package:project_writer_v04/pages/document/story_page/component/story_summary_create_pop.dart';
import 'package:project_writer_v04/services/controller/intro_page_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

//TODO: 스토리 페이지 진행. 우선 시공간과 요약 문장부터.

class StoryPage extends StatelessWidget {
  final String documentId;
  final String documentName;

  final storySummaryController = StorySummaryController.to;

  StoryPage({Key key, this.documentId, this.documentName}) : super(key: key);

  final _scrollController = ScrollController();

  Widget emptyScreen({BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '스토리 요약을 자유롭게 만들어보세요.\n또는 아이디어 노트, 연표 등에서\n가져올 수 있습니다. :)',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w100),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          OutlinedButton(
            style: Theme.of(context).outlinedButtonTheme.style.copyWith(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF3b4445)),
                ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return StorySummaryCreatePopUp();
                  });
            },
            child: Text('스토리 요약 추가'),
          ),
        ],
      ),
    );
  }

  Widget summaryScreen() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: storySummaryController.summaries.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(storySummaryController.summaries[index].time),
                  SizedBox(width: 5.0),
                  Text(storySummaryController.summaries[index].space),
                  SizedBox(width: 5.0),
                  Text(storySummaryController.summaries[index].weather),
                ],
              ),
              Text(storySummaryController.summaries[index].storySummary),
            ],
          );
        },
      ),
    );
  }

  //TODO: 디버그 - 기능 구현중.
  @override
  Widget build(BuildContext context) {
    storySummaryController.readStorySummaries(getDocumentId: documentId);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: documentName,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Obx(() => Container(child: storySummaryController.summaries.isEmpty ? emptyScreen(context: context) : summaryScreen())),
      ),
      floatingActionButton: Visibility(
        visible: storySummaryController.summaries.isEmpty ? false : true,
        child: BasicFloatingButton(
          icon: Icons.add,
          onPressed: () => showDialog(
            context: context,
            builder: (_) {
              return StorySummaryCreatePopUp();
            },
          ),
        ),
      ),
    );
  }
}
