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
  final _yearController = TextEditingController();
  final _dayController = TextEditingController();
  final _quarterController = TextEditingController();

  int _lastMyStoryIdNum = 0;

  var selectedSeason = "한봄";

  List<String> seasons = <String>[
    '초봄',
    '힌봄',
    '늦봄',
    '초여름',
    '한여름',
    '늦여름',
    '초가을',
    '한가을',
    '늦가을',
    '초겨울',
    '한겨울',
    '늦겨울',
  ];

  var selectYear = 1990;

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
    var date = DateTime.now();
    return TextButton(
      onPressed: () {
        showMaterialDatePicker(
          title: '생년월일 선택',
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          context: context,
          selectedDate: date,
          onChanged: (value) => setState(() => date = value),
        );
      },
      child: Text(
        '${date.toString()}',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
      ),
    );
  }

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
                                            year: _yearController.text,
                                            season: _quarterController.text,
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
