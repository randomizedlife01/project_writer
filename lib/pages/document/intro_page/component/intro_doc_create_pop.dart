import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/intro_page_controller.dart';

@immutable
class DocCreatePopUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _docNameController = TextEditingController();
  final _docDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int _lastIdeaIdNum = 0;
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
                                child: GetBuilder<IntroDocumentController>(
                                  builder: (controller) {
                                    return ElevatedButton(
                                      child: Text("저 장"),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();

                                          if (controller.document.isNotEmpty) {
                                            final lastId = controller.document.last.id;
                                            final number = lastId.split("_").last;
                                            _lastIdeaIdNum = int.parse(number);
                                          }

                                          controller.createDoc(
                                            docName: _docNameController.text ?? '무 제',
                                            docDesc: _docDescController.text ?? '아직 없음',
                                            id: 'document_' + (_lastIdeaIdNum + 1).toString(),
                                          );

                                          Navigator.pop(context);
                                        }
                                      },
                                    );
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
  }
}
