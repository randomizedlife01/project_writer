import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/component/my_life_body.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';

@immutable
class MyLifePage extends StatelessWidget {
  final myLifeController = MyLifeStoryController.to;

  @override
  Widget build(BuildContext context) {
    myLifeController.readMyStory();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: '내 삶의 연표',
        ),
      ),
      body: MyLifePageBody(),
      floatingActionButton: Visibility(
        visible: myLifeController.myLifeStory.isEmpty ? false : true,
        child: BasicFloatingButton(
          icon: Icons.add,
          onPressed: () => Navigator.of(context).pushNamed('/my_life_detail_page', arguments: myLifeController.myLifeStory),
        ),
      ),
    );
  }
}
