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

  Widget dropDownButton({BuildContext context, String id, String summary, String storyDetail, String time, String space, String weather}) {
    return DropDownButtons(
      getDocId: documentId,
      context: context,
      onAddDetailTap: () {
        storySummaryController.getSummaryData(
          id: id,
          summary: summary,
          storyDetail: storyDetail,
          time: time,
          space: space,
          weather: weather,
        );
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
      separatorBuilder: (context, index) => Divider(color: Color(0xFF111f4d)),
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
                  onSwitchingTap: () {
                    storySummaryController.changeSummaryVisible(isVisible: !storySummaryController.summaryVisible.value);
                  },
                ),
              )
            : InkWell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: storySummaryController.summaryVisible.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50.0,
                                child: Text(
                                  storySummaryController.summaries[index].time,
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(height: 20.0, child: BasicVerticalLine(width: 5.0)),
                              Expanded(
                                child: Text(
                                  storySummaryController.summaries[index].space,
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(height: 20.0, child: BasicVerticalLine(width: 5.0)),
                              Container(
                                width: 50.0,
                                child: Text(
                                  storySummaryController.summaries[index].weather,
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Visibility(
                          visible: storySummaryController.summaryVisible.value,
                          child: DashedSeparator(color: Color(0xFF111f4d)),
                        ),
                        SizedBox(height: 15.0),
                        Visibility(
                          visible: storySummaryController.summaryVisible.value,
                          child: Text(
                            '요약 : ⌈' + storySummaryController.summaries.value[index].storySummary + '⌋',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Visibility(
                          visible: storySummaryController.summaryVisible.value,
                          child: DashedSeparator(color: Color(0xFF111f4d)),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          storySummaryController.summaries.value[index].storyDetail ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(fontFamily: 'NotoSerifKR', fontSize: 18.0, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 10.0),
                        Obx(
                          () => Visibility(
                            visible: storySummaryController.setDropDownVisible.value,
                            child: dropDownButton(
                              context: context,
                              id: storySummaryController.summaries[index].id,
                              summary: storySummaryController.summaries[index].storySummary,
                              storyDetail: storySummaryController.summaries[index].storyDetail ?? '',
                              time: storySummaryController.summaries[index].time ?? '',
                              space: storySummaryController.summaries[index].space ?? '',
                              weather: storySummaryController.summaries[index].weather ?? '',
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
