import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/bloc/intro_page_bloc.dart';

class DocDeletePopUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _docDeleteKeyController = TextEditingController();

  final FocusNode focusNode;
  final int index;
  final String documentId;

  DocDeletePopUp({Key key, this.focusNode, this.index, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = BlocProvider.of<IntroDocumentCubit>(context);
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
                      Text(
                        '정말로 문서를\n삭제하시겠습니까?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'GothicA1',
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFe23e57),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          '삭제하시려면 아래 상자에\n\'지우기\'를 입력해주세요',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DocInputForm(
                          hintText: '지우기',
                          controller: _docDeleteKeyController,
                          autoFocus: false,
                          onTap: () => _docDeleteKeyController.clear(),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: FlatButton(
                                child: Text("삭 제"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                color: Color(0xFFe23e57),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    if (_docDeleteKeyController.text == '지우기') {
                                      data.deleteDoc(id: data.document[index].id);
                                      Navigator.pop(context);
                                    } else {
                                      _docDeleteKeyController.text = '\'지우기\'를 입력하셔야 합니다.';
                                      FocusScope.of(context).unfocus();
                                      TextEditingController().clear();
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: FlatButton(
                                child: Text('취 소'),
                                color: Colors.white,
                                textColor: Color(0xFF8785a2),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFF8785a2),
                                    width: 0.7,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
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
  }
}
