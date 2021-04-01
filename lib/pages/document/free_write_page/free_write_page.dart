import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_bloc.dart';
import 'package:project_writer_v04/pages/document/free_write_page/parts/free_write_create_pop.dart';
import 'package:project_writer_v04/pages/document/free_write_page/parts/free_write_parts.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FreeWritePage extends StatelessWidget {
  final String appBarTitle;

  FreeWritePage({Key key, this.appBarTitle});

  final memoController = TextEditingController();
  final tagsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _memoController = TextEditingController();
  final _tagsController = TextEditingController();

  int _lastIdeaIdNum = 0;

  _openPopup(context) {
    Alert(
        context: context,
        title: "아이디어 메모 저장",
        style: AlertStyle(
          titleStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: Color(0xff353342)),
        ),
        content: Container(
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
                          child: DocInputForm(hintText: '메모를 입력하세요', labelText: '아이디어 메모 작성', controller: _memoController),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DocInputForm(hintText: '(#제외 검색용 단어 입력)', labelText: '태그', controller: _tagsController),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      '취 소',
                      style: TextStyle(color: Color(0xFFe23e57), fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "저 장",
                      style: TextStyle(color: Color(0xFFf6f6f6), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
              color: Color(0xFFf6f6f6),
              border: Border.all(color: Color(0xFFe23e57), width: 2.0),
              child: Text(
                '취 소',
                style: TextStyle(color: Color(0xFFe23e57), fontSize: 14),
              ),
              onPressed: () {
                print(context);
                Navigator.pop(context);
              }),
          //   DialogButton(
          //     color: Color(0xFFe23e57),
          //     onPressed: () {
          //       // if (_memoController.text.isNotEmpty && _tagsController.text.isNotEmpty) {
          //       //   if (_formKey.currentState.validate()) {
          //       //     _formKey.currentState.save();
          //       //
          //       //     if (snapshot.data.ideaMemo.isNotEmpty) {
          //       //       final lastId = snapshot.data.ideaMemo.last.id;
          //       //       final number = lastId.split("_").last;
          //       //       _lastIdeaIdNum = int.parse(number);
          //       //     }
          //       //     _countBloc.createIdea(
          //       //       memo: _memoController.text ?? '',
          //       //       tag: _tagsController.text ?? '',
          //       //       id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
          //       //     );
          //       //
          //       //     _countBloc.createTag(tag: _tagsController.text);
          //       //
          //       //     Navigator.pop(context);
          //       //   }
          //       // }
          //     },
          //     child: Text(
          //       "저 장",
          //       style: TextStyle(color: Color(0xFFf6f6f6), fontSize: 14),
          //     ),
          //   ),
        ]).show();
  }

  Widget floatingButton() {
    return Container(
      width: 50.0,
      height: 50.0,
      child: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(
          Icons.add,
          size: 25.0,
        ),
        backgroundColor: Color(0xFFe23e57),
        elevation: 0.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _searchHistoryListBloc = BlocProvider.of<FreeWriteBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: appBarTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar(),
      ),
      floatingActionButton: BasicFloatingButton(
        icon: Icons.add,
        onPressed: () => _openPopup(context),
        // onPressed: () => showDialog(
        //   context: context,
        //   builder: (context) {
        //     //도큐멘트 생성 팝업
        //     return FreeWriteCreatePop(
        //       nameHintText: '(#제외 검색용 단어 입력)',
        //       nameLabelText: '태그',
        //       descHintText: '메모를 입력하세요',
        //       descLabelText: '아이디어 메모 작성',
        //       //index: (state as IdeasLoadSuccess).ideaMemo.length,
        //     );
        //   },
        // ),
      ),
    );
  }
}
