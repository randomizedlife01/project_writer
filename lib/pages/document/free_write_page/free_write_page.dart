import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:project_writer_v04/models/IdeaMemo.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/common_parts/common_create_pop.dart';
import 'package:project_writer_v04/services/logic/idea_note_bloc.dart';

class FreeWritePage extends StatelessWidget {
  final String appBarTitle;

  FreeWritePage({Key key, this.appBarTitle});

  final memoController = TextEditingController();
  final tagsController = TextEditingController();

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
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            //도큐멘트 생성 팝업
            return CommonCreatePop(
              nameHintText: '메모를 입력하세요',
              nameLabelText: '아이디어 메모 작성',
              descHintText: '(#제외 검색용 단어 입력)',
              descLabelText: '태그',
            );
          },
        ),
      ),
    );
  }
}
