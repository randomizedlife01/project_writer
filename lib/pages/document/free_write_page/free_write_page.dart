import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/parts/free_write_create_pop.dart';
import 'package:project_writer_v04/pages/document/free_write_page/parts/free_write_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_bloc.dart';

class FreeWritePage extends StatefulWidget {
  final String appBarTitle;

  FreeWritePage({Key key, this.appBarTitle});

  @override
  _FreeWritePageState createState() => _FreeWritePageState();
}

class _FreeWritePageState extends State<FreeWritePage> {
  final memoController = TextEditingController();
  final tagsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FreeWriteCubit>(context).readIdeaAndTags();
  }

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
          appBarTitle: widget.appBarTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SearchBar(),
      ),
      floatingActionButton: BasicFloatingButton(
        icon: Icons.add,
        //onPressed: () => _openPopup(context),
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: BlocProvider.of<FreeWriteCubit>(context),
              child: FreeWriteCreatePop(
                nameLabelText: '태그 입력',
                nameHintText: '#제외, 띄어쓰기로 구분합니다.',
                descLabelText: '아이디어 메모 작성',
                descHintText: '떠오른 아이디어를 작성해 주세요',
              ),
            );
          },
        ),
      ),
    );
  }
}
