import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_bloc.dart';

class MyLifeCreatePop extends StatelessWidget {
  final String nameLabelText;
  final String nameHintText;
  final int index;

  MyLifeCreatePop({Key key, this.nameLabelText, this.nameHintText, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _memoController = TextEditingController();
  final _tagsController = TextEditingController();

  Widget dateWheelPicker(BuildContext context) {
    DateTime now = new DateTime.now();
    return TextButton(
      onPressed: () {
        DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(1930, 1, 1),
            maxTime: DateTime(now.year, now.month, now.day),
            onChanged: (date) {}, onConfirm: (date) {
          //TODO: 태어난 날짜 선택하기
        }, currentTime: DateTime.now(), locale: LocaleType.ko);
      },
      child: Text(
        '소중한 당신 삶의 시작을 알려주세요',
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12.0),
      ),
    );
  }

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
                                child: DocInputForm(hintText: nameHintText, labelText: nameLabelText, controller: _memoController),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: dateWheelPicker(context),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                          if (_memoController.text.isNotEmpty && _tagsController.text.isNotEmpty) {
                                            if (_formKey.currentState.validate()) {
                                              _formKey.currentState.save();

                                              // if (state.ideaMemo.isNotEmpty) {
                                              //   final lastId = state.ideaMemo.last.id;
                                              //   final number = lastId.split("_").last;
                                              //   _lastIdeaIdNum = int.parse(number);
                                              // }
                                              //
                                              // //TODO: 아이디어 생성
                                              // BlocProvider.of<FreeWriteCubit>(context).createIdea(
                                              //   memo: _memoController.text ?? '',
                                              //   tag: _tagsController.text ?? '',
                                              //   id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
                                              // );

                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
