import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

class StoryDetailPage extends StatefulWidget {
  @override
  _StoryDetailPageState createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  final _focusNode = FocusNode();

  final _storySummaryController = StorySummaryController.to;
  final _characterController = CharactersController.to;
  final _scrollController = ScrollController();

  TextEditingController _storyDetailController = TextEditingController();
  TextEditingController _storyController = TextEditingController();

  final _timeList = ['새벽', '아침', '낮', '오후', '저녁', '밤', '늦은 밤'];
  final _weatherList = ['미정', '맑음', '비', '눈', '흐림', '갬'];

  String _getTime = '';

  TextEditingController _spaceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _characterController.readMyCharacters();
    _storyDetailController = TextEditingController(text: _storySummaryController.storyDetails.value ?? '');
    _storyController = TextEditingController(text: _storySummaryController.getSummary.value ?? '');
    _spaceController = TextEditingController(text: _storySummaryController.spaceList.value ?? '');
  }

  Widget characterListBar(String id) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: _characterController.myCharacters.length,
      itemBuilder: (context, index) {
        return TextButton(
          onPressed: () {
            _storyDetailController.text =
                _storySummaryController.addCharacterName(charactersController: _characterController, index: index);
            _storyDetailController.selection = TextSelection.fromPosition(TextPosition(offset: _storyDetailController.text.length));
          },
          child: Text(_characterController.myCharacters[index].name),
        );
      },
    );
  }

  KeyboardActionsConfig _buildConfig(BuildContext context, String id) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _focusNode,
          footerBuilder: (_) => PreferredSize(
              child: SizedBox(
                  height: 40,
                  child: Center(
                    child: characterListBar(id),
                  )),
              preferredSize: Size.fromHeight(40)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: '스토리 쓰기/수정',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600),
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
                      Expanded(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                          controller: _spaceController,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '장소는 비울 수 없습니다 :(';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          onChanged: (value) => _storySummaryController.changeSpace(value: value),
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "장소",
                          ),
                        ),
                      ),
                      DropdownButton(
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600),
                        value: _storySummaryController.selectWeathers.value,
                        items: _weatherList
                            .map(
                              (value) => DropdownMenuItem(
                                child: Obx(() => Text(_storySummaryController.selectWeathers.value)),
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
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16.0, fontWeight: FontWeight.w600),
                controller: _storyController,
                autocorrect: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '문단 요약은 비울 수 없습니다 :(';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) => _storySummaryController.changeSummary(value: value),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "문단 요약 :)",
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: KeyboardActions(
                  config: _buildConfig(context, _storySummaryController.summaryId.value),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16.0),
                    controller: _storyDetailController,
                    focusNode: _focusNode,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '디테일한 스토리는 비울 수 없습니다 :(';
                      }
                      return null;
                    },
                    onChanged: (value) => _storySummaryController.changeSummaryDetail(value: value),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "디테일한 스토리를 적어주세요 :)",
                    ),
                  ),
                ),
              ),
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
                              id: _storySummaryController.summaryId.value,
                              storyDetail: _storyDetailController.text,
                              storySummary: _storyController.text,
                              time: _storySummaryController.selectTimes.value,
                              space: _spaceController.text,
                              weather: _storySummaryController.selectWeathers.value,
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
      ),
    );
  }

  @override
  void dispose() {
    _storySummaryController.onClose();
    _characterController.onClose();
    super.dispose();
  }
}
