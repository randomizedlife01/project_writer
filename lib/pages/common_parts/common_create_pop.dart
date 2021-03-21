import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/logic/idea_note_bloc.dart';
import 'package:project_writer_v04/services/logic/idea_note_event.dart';
import 'package:project_writer_v04/services/logic/idea_tags_bloc.dart';
import 'package:project_writer_v04/services/logic/idea_tags_event.dart';

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

  @override
  Widget build(BuildContext context) {
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
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                BlocProvider.of<IdeaBloc>(context).add(
                                  IdeaAdded(
                                    IdeaMemo(
                                      id: 'idea_Id' + index.toString(),
                                      memo: _memoController.text ?? '',
                                    ),
                                  ),
                                );

                                List<String> tagsList = _tagsController.text.split(" ");

                                tagsList.forEach((tag) {
                                  BlocProvider.of<TagsBloc>(context).add(TagAdded(SearchTags(tag: tag)));
                                });

                                Navigator.pop(context);
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
  }
}
