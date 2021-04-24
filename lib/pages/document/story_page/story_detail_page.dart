import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

class StoryDetailPage extends StatelessWidget {
  final storySummaryController = StorySummaryController.to;

  @override
  Widget build(BuildContext context) {
    final storyDetailController = TextEditingController(text: storySummaryController.storyDetails.value ?? '');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: '스토리 쓰기',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(
              () => Text(
                storySummaryController.getSummary.value,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: TextFormField(
                controller: storyDetailController,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '디테일한 스토리는 비울 수 없습니다 :(';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "디테일한 스토리를 적어주세요 :)"),
              ),
            ),
            //TODO: 스토리 디테일 저장 버튼
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.transparent),
                    child: Text("취 소"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GetBuilder<StorySummaryController>(
                    builder: (controller) {
                      return ElevatedButton(
                        child: Text("저 장"),
                        onPressed: () {
                          controller.updateSummary(
                            id: storySummaryController.summaryId.value,
                            storyDetail: storyDetailController.text,
                          );

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
