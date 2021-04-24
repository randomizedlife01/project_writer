import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_writer_v04/models/ModelProvider.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/component/my_life_body.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/component/my_life_create_pop.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';

@immutable
class MyLifePage extends StatelessWidget {
  final myLifeController = MyLifeStoryController.to;

  @override
  Widget build(BuildContext context) {
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
          onPressed: () => showDialog(
            context: context,
            builder: (_) {
              return MyLifeCreatePop(
                nameLabelText: '태그 입력',
                nameHintText: '#제외, 띄어쓰기로 구분합니다.',
              );
            },
          ),
        ),
      ),
    );
  }
}
