import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/bloc/intro_page_bloc.dart';

class DocCreatePopUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  int _lastIdeaIdNum = 0;

  final _docNameController = TextEditingController();
  final _docDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroDocumentCubit, IntroDocumentState>(
      builder: (context, state) {
        if (state is IntroDocumentLoaded) {
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
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: DocInputForm(hintText: '무제', labelText: '스토리 제목', controller: _docNameController),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: DocInputForm(hintText: '한줄 설명', labelText: '스토리의 한줄 설명', controller: _docDescController),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('취 소'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        child: Text("저 장"),
                                        onPressed: () {
                                          if (_formKey.currentState.validate()) {
                                            _formKey.currentState.save();

                                            if (state.document.isNotEmpty) {
                                              final lastId = state.document.last.id;
                                              final number = lastId.split("_").last;
                                              _lastIdeaIdNum = int.parse(number);
                                            }

                                            //TODO: 아이디어 생성
                                            BlocProvider.of<IntroDocumentCubit>(context).createDoc(
                                              docName: _docNameController.text ?? '무 제',
                                              docDesc: _docDescController.text ?? '아직 없음',
                                              id: 'document_' + (_lastIdeaIdNum + 1).toString(),
                                            );

                                            Navigator.pop(context);
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
        } else if (state is IntroDocumentLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text('ERROR!!'),
          );
        }
      },
    );
  }
}
