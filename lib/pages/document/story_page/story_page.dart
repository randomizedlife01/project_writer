import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/story_page/component/story_summary_create_pop.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

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

  Widget dropDownButton(BuildContext context, String id, String summary, String storyDetail) {
    return DropDownButtons(
      getDocId: documentId,
      context: context,
      onAddDetailTap: () {
        storySummaryController.getSummaryData(id: id, summary: summary, storyDetail: storyDetail);
        Navigator.of(context).pushNamed('/story_detail_page');
      },
      onImportTap: () => Navigator.of(context).pushNamed('/import_page'),
      onDeleteTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return DeletePopup(
                id: id,
                delete: () {
                  storySummaryController.deleteSummary(id: id);
                  Navigator.pop(context);
                },
              );
            });
      },
    );
  }

  Widget summaryScreen() {
    return ListView.separated(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: storySummaryController.summaries.length + 1,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final widgetItem = index == storySummaryController.summaries.length
            ? Visibility(
                visible: storySummaryController.summaries.isEmpty ? false : true,
                child: AddButtonBar(
                  getDocId: documentId,
                  context: context,
                  scrollController: _scrollController,
                  onAddSentenceTap: () => showDialog(
                    context: context,
                    builder: (_) {
                      return StorySummaryCreatePopUp(documentId: documentId);
                    },
                  ),
                  onAddTalkTap: () {},
                  onImportTap: () {
                    Navigator.of(context).pushNamed('/import_page');
                  },
                ),
              )
            : InkWell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Obx(
                    () => Column(
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
                        Text(storySummaryController.summaries.value[index].storySummary),
                        SizedBox(height: 10.0),
                        Text(storySummaryController.summaries.value[index].storyDetail ?? ''),
                        SizedBox(height: 10.0),
                        Obx(
                          () => Visibility(
                            visible: storySummaryController.setDropDownVisible.value,
                            child: dropDownButton(
                              context,
                              storySummaryController.summaries[index].id,
                              storySummaryController.summaries[index].storySummary,
                              storySummaryController.summaries[index].storyDetail ?? '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  storySummaryController.selectDropDownVisible(isVisible: !storySummaryController.setDropDownVisible.value);
                },
              );
        return widgetItem;
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
        padding: EdgeInsets.all(20.0),
        child: Obx(() => Container(child: storySummaryController.summaries.isEmpty ? emptyScreen(context: context) : summaryScreen())),
      ),
    );
  }
}
