import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/re_free_cubit.dart';

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

  @override
  Widget build(BuildContext context) {
    final _ideaBloc = BlocProvider.of<ReFreeCubit>(context, listen: false);
    return BlocBuilder<ReFreeCubit, FreeWriteState>(
      builder: (context, state) {
        if (state is StateOfIdeasLoaded) {
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

                                        if (state.ideaMemo.isNotEmpty) {
                                          final lastId = state.ideaMemo.last.id;
                                          final number = lastId.split("_").last;
                                          _lastIdeaIdNum = int.parse(number);
                                        }

                                        //TODO: 아이디어 생성
                                        _ideaBloc.createIdea(
                                          memo: _memoController.text ?? '',
                                          tag: _tagsController.text ?? '',
                                          id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
                                        );

                                        //TODO: 태그 생성
                                        //_countBloc.createTag(tag: _tagsController.text);

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
        } else if (state is StateOfIdeasLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('Nod data!!!!!'),
          );
        }
      },
    );
  }
}
