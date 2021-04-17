import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/free_write_controller.dart';

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
    return GetBuilder<FreeWriteController>(
      builder: (controller) {
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      child: Text("취 소"),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text("저 장"),
                                      onPressed: () {
                                        if (_memoController.text.isNotEmpty && _tagsController.text.isNotEmpty) {
                                          if (_formKey.currentState.validate()) {
                                            _formKey.currentState.save();

                                            if (controller.ideaMemo.isNotEmpty) {
                                              final lastId = controller.ideaMemo.last.id;
                                              final number = lastId.split("_").last;
                                              _lastIdeaIdNum = int.parse(number);
                                            }

                                            controller.createIdea(
                                              memo: _memoController.text ?? '',
                                              tag: _tagsController.text ?? '',
                                              id: 'idea_' + (_lastIdeaIdNum + 1).toString(),
                                            );

                                            controller.createTag(tag: _tagsController.text);

                                            Navigator.pop(context);
                                          }
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
      },
    );
  }
}
