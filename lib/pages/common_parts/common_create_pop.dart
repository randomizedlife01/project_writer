import 'package:flutter/material.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/logic/bloc_base.dart';
import 'package:project_writer_v04/services/logic/ideaAndTags_bloc.dart';

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
    var _countBloc = BlocProvider.of<IdeasAndTagsBloc>(context);
    return StreamBuilder<IdeaAndTagModel>(
        stream: _countBloc.moviesUserFavouritesStream(),
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
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      _countBloc.addIdea(
                                          memo: _memoController.text ?? '',
                                          tags: _tagsController.text ?? '',
                                          //TODO: 저장 아이디 체크하기. 잘못되서 들어옴.
                                          //TODO: 현재 탭한 ListTile의 아이디를 읽어오기.
                                          id: 'idea_Id' + snapshot.data.idea.length.toString());
                                      // BlocProvider.of<IdeaBloc>(context).add(
                                      //   IdeaAdded(
                                      //     IdeaMemo(memo: _memoController.text ?? '', tags: _tagsController.text ?? ''),
                                      //   ),
                                      // );

                                      // List<String> tagsList = _tagsController.text.split(" ");
                                      //
                                      // tagsList.forEach((tag) {
                                      //   BlocProvider.of<TagsBloc>(context).add(TagAdded(SearchTags(tag: tag)));
                                      // });

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
        });
  }
}
