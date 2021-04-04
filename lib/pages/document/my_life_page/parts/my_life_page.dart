import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/bloc/my_life_bloc.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/parts/my_life_create_pop.dart';

class MyLifePage extends StatefulWidget {
  @override
  _MyLifePageState createState() => _MyLifePageState();
}

class _MyLifePageState extends State<MyLifePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyLifeStoryCubit>(context).readMyStory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Text('아직 연표가 없네요.\n내 이야기로 연표를 만들어보세요 :)'),
        ),
      ),
      floatingActionButton: BasicFloatingButton(
        icon: Icons.add,
        onPressed: () => showDialog(
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: BlocProvider.of<MyLifeStoryCubit>(context),
              child: MyLifeCreatePop(
                nameLabelText: '태그 입력',
                nameHintText: '#제외, 띄어쓰기로 구분합니다.',
              ),
            );
          },
        ),
      ),
    );
  }
}
