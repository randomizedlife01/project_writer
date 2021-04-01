import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FreeWriteCreatePop extends StatelessWidget {
  final String descLabelText;
  final String nameLabelText;
  final String descHintText;
  final String nameHintText;
  final int index;

  FreeWriteCreatePop({Key key, this.descLabelText, this.nameLabelText, this.descHintText, this.nameHintText, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _memoController = TextEditingController();
  final _tagsController = TextEditingController();

  int _lastIdeaIdNum = 0;
  int _lastSearchNum = 0;

  _openPopup(context, snapshot) {
    var _countBloc = BlocProvider.of<FreeWriteBloc>(context);
    Alert(
        context: context,
        title: "LOGIN",
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
                          child: DocInputForm(hintText: descHintText, labelText: descLabelText, controller: _memoController),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DocInputForm(hintText: nameHintText, labelText: nameLabelText, controller: _tagsController),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: Text("저 장"),
                            onPressed: () {
                              if (_memoController.text.isNotEmpty && _tagsController.text.isNotEmpty) {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  if (snapshot.data.ideaMemo.isNotEmpty) {
                                    final lastId = snapshot.data.ideaMemo.last.id;
                                    final number = lastId.split("_").last;
                                    _lastIdeaIdNum = int.parse(number);
                                  }
                                  _countBloc.createIdea(
                                    memo: _memoController.text ?? '',
                                    tag: _tagsController.text ?? '',
                                    id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
                                  );

                                  _countBloc.createTag(tag: _tagsController.text);

                                  Navigator.pop(context);
                                }
                              }
                            },
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
        buttons: [
          DialogButton(
            onPressed: () {
              if (_memoController.text.isNotEmpty && _tagsController.text.isNotEmpty) {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  if (snapshot.data.ideaMemo.isNotEmpty) {
                    final lastId = snapshot.data.ideaMemo.last.id;
                    final number = lastId.split("_").last;
                    _lastIdeaIdNum = int.parse(number);
                  }
                  _countBloc.createIdea(
                    memo: _memoController.text ?? '',
                    tag: _tagsController.text ?? '',
                    id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
                  );

                  _countBloc.createTag(tag: _tagsController.text);

                  Navigator.pop(context);
                }
              }
            },
            child: Text(
              "저 장",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    var _countBloc = BlocProvider.of<FreeWriteBloc>(context);
    return StreamBuilder<FreeWriteModel>(
        stream: _countBloc.combineStream(),
        builder: (context, snapshot) {
          return _openPopup(context, snapshot);
        });
  }
}