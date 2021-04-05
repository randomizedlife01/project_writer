import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_bloc.dart';

class MyLifeCreatePop extends StatelessWidget {
  final String nameLabelText;
  final String nameHintText;
  final int index;

  MyLifeCreatePop({Key key, this.nameLabelText, this.nameHintText, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _storyController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  final _quarterController = TextEditingController();

  Widget dateInputForm(BuildContext context, {String hintText, TextEditingController controller}) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1.copyWith(color: Color(0xFF3b4445), fontWeight: FontWeight.w300, fontSize: 16.0),
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xFFe23e57),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xFF8785a2),
              width: 1.0,
            ),
          ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Color(0xffafbbbd), fontWeight: FontWeight.w300, fontSize: 16.0),
        ),
      ),
    );
  }

  Widget emptyLifeStoryPopUp(BuildContext context) {
    return Column(
      children: [
        Text(
          '소중한 당신 삶의\n시작을 알려주세요',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Color(0xFF3b4445), fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          height: 40,
          child: Row(
            children: [
              dateInputForm(context, hintText: '1990', controller: _yearController),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '년',
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
              ),
              SizedBox(
                width: 10.0,
              ),
              dateInputForm(context, hintText: '01', controller: _monthController),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '월',
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
              ),
              SizedBox(
                width: 10.0,
              ),
              dateInputForm(context, hintText: '31', controller: _dayController),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '일',
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget myLifeDateInput(BuildContext context) {
    return Column(
      children: [
        Expanded(child: DocInputForm(hintText: nameHintText, labelText: nameLabelText, controller: _storyController)),
        SizedBox(
          height: 8.0,
        ),
        Container(
          height: 40,
          child: Row(
            children: [
              dateInputForm(context, hintText: '1990', controller: _yearController),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '년',
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
              ),
              SizedBox(
                width: 10.0,
              ),
              dateInputForm(context, hintText: '1', controller: _quarterController),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '분',
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //TODO: 지금 생각해보니 연월일이 아니라 분기로 하기로 했잖아?????

  // Widget dateWheelPicker(BuildContext context) {
  //   DateTime now = new DateTime.now();
  //   return TextButton(
  //     onPressed: () {
  //       DatePicker.showDatePicker(context,
  //           showTitleActions: true,
  //           minTime: DateTime(1930, 1, 1),
  //           maxTime: DateTime(now.year, now.month, now.day),
  //           onChanged: (date) {}, onConfirm: (date) {=
  //       }, currentTime: DateTime.now(), locale: LocaleType.ko);
  //     },
  //     child: Text(
  //       '소중한 당신 삶의 시작을 알려주세요',
  //       style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12.0),
  //     ),
  //   );
  // }

  //TODO:+++++++++++++++++++++++++연표 작성을 분기로 하면 어떻게 정렬을 하지?++++++++++++++++++++++++++++++++//

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyLifeStoryCubit, MyLifeStoryState>(
      builder: (context, state) {
        if (state is MyLifeStoryLoaded) {
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
                                child: state.myLifeStory.isNotEmpty
                                    ? DocInputForm(hintText: nameHintText, labelText: nameLabelText, controller: _storyController)
                                    : emptyLifeStoryPopUp(context),
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
                                        if (state.myLifeStory.isNotEmpty) {
                                          //TODO: 연표 데이터가 있을 경우 저장하는 곳.
                                          if (_storyController.text.isNotEmpty && _quarterController.text.isNotEmpty) {
                                            if (_formKey.currentState.validate()) {
                                              _formKey.currentState.save();

                                              // if (state.ideaMemo.isNotEmpty) {
                                              //   final lastId = state.ideaMemo.last.id;
                                              //   final number = lastId.split("_").last;
                                              //   _lastIdeaIdNum = int.parse(number);
                                              // }
                                              //
                                              // BlocProvider.of<FreeWriteCubit>(context).createIdea(
                                              //   memo: _memoController.text ?? '',
                                              //   tag: _tagsController.text ?? '',
                                              //   id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
                                              // );

                                              Navigator.pop(context);
                                            }
                                          }
                                        } else if (state.myLifeStory.isEmpty) {
                                          if (_yearController.text.isNotEmpty &&
                                              _monthController.text.isNotEmpty &&
                                              _dayController.text.isNotEmpty) {
                                            if (_formKey.currentState.validate()) {
                                              _formKey.currentState.save();

                                              //TODO: 연표가 비었을 때 저장하는 곳
                                            }
                                          }
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
        } else if (state is MyLifeStoryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('ERROR!'),
          );
        }
      },
    );
  }
}
