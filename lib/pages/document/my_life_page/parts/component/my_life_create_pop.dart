import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';

class MyLifeCreatePop extends StatefulWidget {
  final String nameLabelText;
  final String nameHintText;
  final int index;

  MyLifeCreatePop({Key key, this.nameLabelText, this.nameHintText, this.index}) : super(key: key);

  @override
  _MyLifeCreatePopState createState() => _MyLifeCreatePopState();
}

class _MyLifeCreatePopState extends State<MyLifeCreatePop> {
  final _formKey = GlobalKey<FormState>();
  final _storyController = TextEditingController();
  final _yearController = TextEditingController();
  final _seasonController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();

  String dropdownValue = '봄';

  final myLifeController = MyLifeStoryController.to;

  Widget birthdayForm() {
    return Row(
      children: [
        Expanded(
          child: DocInputForm(
            hintText: '3',
            labelText: '월',
            controller: _monthController,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: DocInputForm(
            hintText: '10',
            labelText: '일',
            controller: _dayController,
          ),
        ),
      ],
    );
  }

  Widget memoryForm() {
    return Row(
      children: [
        Expanded(
          child: DropdownButton(
            value: dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>['봄', '여름', '가을', '겨울'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget myLifeForm({MyLifeStoryController state}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: DocInputForm(
              hintText: '1990',
              labelText: '연도',
              controller: _yearController,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          state.myLifeStory.isEmpty ? Expanded(child: birthdayForm()) : Expanded(child: memoryForm()),
        ],
      ),
    );
  }

  Widget lifeStoryPopUp({BuildContext context, MyLifeStoryController state, String labelText, String hintText}) {
    return Column(
      children: [
        Expanded(
          child: state.myLifeStory.isEmpty
              ? Text(
                  '소중한 당신 삶의\n시작을 알려주세요 :)',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Color(0xFF3b4445), fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )
              : DocInputForm(hintText: hintText, labelText: labelText, controller: _storyController),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          height: 60,
          child: myLifeForm(state: state),
        ),
      ],
    );
  }

  //TODO: 새 데이터 모델 쓰기 수정 중....
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFf6f6f6),
      content: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: <Widget>[
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: lifeStoryPopUp(context: context, state: myLifeController, labelText: '그 때의 이야기', hintText: '이야기를 적어주세요'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                child: Text("취 소"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                child: Text("저 장"),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                    if (dropdownValue == '봄') {
                                      _seasonController.text = '1';
                                    } else if (dropdownValue == '여름') {
                                      _seasonController.text = '2';
                                    } else if (dropdownValue == '가을') {
                                      _seasonController.text = '3';
                                    } else {
                                      _seasonController.text = '4';
                                    }

                                    myLifeController.createMyStory(
                                      lifeMemo: _storyController.text.isNotEmpty ? _storyController.text : '나의 시작',
                                      year: _yearController.text,
                                      season: _seasonController.text,
                                      month: _monthController.text,
                                      day: _dayController.text,
                                    );

                                    Navigator.pop(context);
                                  }
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
