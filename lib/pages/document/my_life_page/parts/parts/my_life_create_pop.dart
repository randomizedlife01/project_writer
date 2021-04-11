import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/helpers/show_date_picker.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_bloc.dart';

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

  int _lastMyStoryIdNum = 0;
  String birthDayData = '';
  var selectedSeason = "봄";
  var date = DateTime.now();

  List<String> seasons = <String>['봄', '여름', '가을', '겨울'];

  var selectYear = 1990;

  String year = '';
  String season = '';
  String month = '';
  String day = '';
  String seasonToHangul = '';

  Widget seasonSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            final getYear = DateTime.now().toString();
            final yearText = getYear.substring(0, 4);

            showMaterialNumberPicker(
              context: context,
              title: "연도를 선택하세요",
              maxNumber: int.parse(yearText),
              minNumber: 1930,
              selectedNumber: selectYear,
              onChanged: (value) {
                setState(() {
                  selectYear = value;
                });
              },
            );
          },
          child: Text(
            '${selectYear.toString()}',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
          ),
        ),
        //dateInputForm(context, hintText: '1990', controller: _yearController),
        Text('년,   그 해', style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16)),
        TextButton(
          onPressed: () {
            showMaterialScrollPicker(
              context: context,
              title: "계절",
              items: seasons,
              selectedItem: selectedSeason,
              onChanged: (value) {
                setState(() {
                  selectedSeason = value;
                });
              },
            );
          },
          child: Text(
            '$selectedSeason',
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
          ),
        ),
        //dateInputForm(context, hintText: '01', controller: _quarterController),
        // SizedBox(
        //   width: 10.0,
        // ),
        // dateInputForm(context, hintText: '31', controller: _dayController),
        // SizedBox(
        //   width: 5.0,
        // ),
        // Text(
        //   '일',
        //   style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
        // ),
      ],
    );
  }

  Widget notingData() {
    return TextButton(
      onPressed: () {
        showMaterialDatePicker(
          title: '생년월일 선택',
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          context: context,
          selectedDate: date,
          onChanged: (value) => setState(() {
            year = value.year.toString();
            season = '';
            if ((value.month.toInt() >= 1 && value.month.toInt() < 3) || (value.month.toInt() == 12)) {
              seasonToHangul = '겨울';
              season = '01';
            } else if (value.month.toInt() >= 3 && value.month.toInt() < 6) {
              seasonToHangul = '봄';
              season = '02';
            } else if (value.month.toInt() >= 6 && value.month.toInt() < 9) {
              seasonToHangul = '여름';
              season = '03';
            } else if (value.month.toInt() >= 9 && value.month.toInt() < 12) {
              seasonToHangul = '가을';
              season = '04';
            }
          }),
        );
      },
      child: Text(
        '${'$year년, 그 해 $seasonToHangul'}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
      ),
    );
  }

  Widget lifeStoryPopUp({BuildContext context, MyLifeStoryState state, String labelText, String hintText}) {
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
          height: 40,
          child: state.myLifeStory.isNotEmpty ? seasonSelector() : notingData(),
        ),
      ],
    );
  }

  //TODO: 저장 기능 완료하기.
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
                                child: lifeStoryPopUp(context: context, state: state, labelText: '그 때의 이야기', hintText: '이야기를 적어주세요'),
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

                                          if (state.myLifeStory.isNotEmpty) {
                                            final lastId = state.myLifeStory.last.id;
                                            final number = lastId.split("_").last;
                                            _lastMyStoryIdNum = int.parse(number);
                                          }

                                          BlocProvider.of<MyLifeStoryCubit>(context).createMyStory(
                                            id: 'my_life_' + (_lastMyStoryIdNum + 1).toString(),
                                            lifeMemo: _storyController.text.isNotEmpty ? _storyController.text : '나의 시작',
                                            year: year,
                                            season: season,
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
