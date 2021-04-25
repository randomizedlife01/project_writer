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
  final storySummaryController = StorySummaryController.to;

  final focusNode = FocusNode();

  final custom1Notifier = ValueNotifier<String>("0");

  final characterController = CharactersController.to;

  final scrollController = ScrollController();

  TextEditingController storyDetailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    characterController.readMyCharacters();
    storyDetailController = TextEditingController(text: storySummaryController.storyDetails.value ?? '');
  }

  Widget characterListBar(String id) {
    return ListView.builder(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: characterController.myCharacters.length,
      itemBuilder: (context, index) {
        return TextButton(
          onPressed: () {
            setState(() {
              storyDetailController.text = ('${storyDetailController.text}\n' + characterController.myCharacters[index].name + ' : ');
            });
          },
          child: Text(characterController.myCharacters[index].name),
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
          focusNode: focusNode,
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
    storyDetailController.selection = TextSelection.fromPosition(TextPosition(offset: storyDetailController.text.length));
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              storySummaryController.getSummary.value,
              maxLines: null,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: KeyboardActions(
                config: _buildConfig(context, storySummaryController.summaryId.value),
                child: TextFormField(
                  controller: storyDetailController,
                  focusNode: focusNode,
                  autocorrect: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '디테일한 스토리는 비울 수 없습니다 :(';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      storyDetailController.text = value;
                    });
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
