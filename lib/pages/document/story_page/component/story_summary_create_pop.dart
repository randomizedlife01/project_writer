import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

@immutable
class StorySummaryCreatePopUp extends StatelessWidget {
  final documentId;

  final _formKey = GlobalKey<FormState>();
  final _storySummaryController = StorySummaryController.to;

  final _timeList = ['없음', '새벽', '아침', '낮', '오후', '저녁', '밤', '늦은 밤'];
  final _weatherList = ['없음', '맑음', '비', '눈', '흐림', '갬'];

  final _spaceController = TextEditingController();
  final _summaryController = TextEditingController();

  StorySummaryCreatePopUp({Key key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _lastIdeaIdNum = 0;
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: <Widget>[
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: DocInputForm(hintText: '한줄 설명', labelText: '스토리의 한줄 설명', controller: _summaryController),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '선택사항',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(child: DocInputForm(hintText: '장소를 입력해주세요', labelText: '장소', controller: _spaceController)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton(
                              value: _storySummaryController.selectTimes.value,
                              items: _timeList
                                  .map(
                                    (value) => DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                _storySummaryController.selectTime(timeValue: value);
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            DropdownButton(
                              value: _storySummaryController.selectWeathers.value,
                              items: _weatherList
                                  .map(
                                    (value) => DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                _storySummaryController.selectWeather(weatherValue: value);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('취 소'),
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: GetBuilder<StorySummaryController>(
                                builder: (controller) {
                                  return ElevatedButton(
                                    child: Text("저 장"),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();

                                        if (controller.summaries.isNotEmpty) {
                                          final lastId = controller.summaries.last.id;
                                          final number = lastId.split("_").last;
                                          _lastIdeaIdNum = int.parse(number);
                                        }

                                        controller.createSummary(
                                          id: 'my_summary_' + (_lastIdeaIdNum + 100000).toString(),
                                          documentId: _storySummaryController.setDocumentId.value,
                                          storySummary: _summaryController.text ?? '미입력',
                                          space: _spaceController.text ?? '미입력',
                                          time: _storySummaryController.selectTimes.value,
                                          weather: _storySummaryController.selectWeathers.value,
                                        );

                                        Navigator.pop(context);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
