import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/idea_bloc.dart';

class CommonCreatePop extends StatelessWidget {
  final String descLabelText;
  final String nameLabelText;
  final String descHintText;
  final String nameHintText;
  final int index;

  CommonCreatePop({Key key, this.descLabelText, this.nameLabelText, this.descHintText, this.nameHintText, this.index}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _memoController = TextEditingController();
  final _tagsController = TextEditingController();

  var _latIdNum = 0;

  @override
  Widget build(BuildContext context) {
    var _countBloc = BlocProvider.of<IdeasBloc>(context);
    return StreamBuilder<List<IdeaMemo>>(
        stream: _countBloc.ideaStream,
        builder: (context, snapshot) {
          return AlertDialog(
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

                                        if (snapshot.data.isNotEmpty) {
                                          final lastId = snapshot.data.last.id;
                                          final number = lastId.split("_").last;
                                          _latIdNum = int.parse(number);
                                        }

                                        _countBloc.addIdea(
                                          memo: _memoController.text ?? '',
                                          tags: _tagsController.text ?? '',
                                          id: 'idea_' + (_latIdNum + 1).toString(),
                                        );

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
            ),
          );
        });
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(
        label,
        style: TextStyle(fontSize: 13.0),
      ),
      deleteIcon: const Icon(
        Icons.close,
        size: 12,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
