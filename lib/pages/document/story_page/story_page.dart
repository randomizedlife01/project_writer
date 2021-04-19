import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_parts.dart';
import 'package:project_writer_v04/services/controller/intro_page_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

//TODO: 스토리 페이지 진행. 우선 시공간과 요약 문장부터.

class StoryPage extends StatelessWidget {
  final String documentId;
  final String documentName;

  final storySummaryController = StorySummaryController.to;

  StoryPage({Key key, this.documentId, this.documentName}) : super(key: key);

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
              // showDialog(
              //     context: context,
              //     builder: (_) {
              //       return MyLifeCreatePop(
              //         nameLabelText: '태그 입력',
              //         nameHintText: '#제외, 띄어쓰기로 구분합니다.',
              //       );
              //     });
            },
            child: Text('스토리 요약 추가'),
          ),
        ],
      ),
    );
  }

  Widget summaryScreen() {
    return ListView.builder(
      itemCount: storySummaryController.summaries.length,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }

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
        child: Container(child: storySummaryController.summaries.isEmpty ? emptyScreen(context: context) : summaryScreen()),
      ),
      floatingActionButton: Visibility(
        visible: storySummaryController.summaries.isEmpty ? false : true,
        child: BasicFloatingButton(
          icon: Icons.add,
          onPressed: () {},
          // onPressed: () => showDialog(
          //   context: context,
          //   builder: (_) {
          //     return FreeWriteCreatePop(
          //       nameLabelText: '태그 입력',
          //       nameHintText: '#제외, 띄어쓰기로 구분합니다.',
          //       descLabelText: '아이디어 메모 작성',
          //       descHintText: '떠오른 아이디어를 작성해 주세요',
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
