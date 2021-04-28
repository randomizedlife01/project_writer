import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/component/free_search_bar.dart';
import 'package:project_writer_v04/pages/document/my_life_page/parts/component/my_life_body.dart';
import 'package:project_writer_v04/services/controller/free_write_controller.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';

class ImportPage extends StatefulWidget {
  @override
  _ImportPageState createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> with SingleTickerProviderStateMixin {
  TabController ctr;

  final freeWriteController = FreeWriteController.to;
  final myLifeController = MyLifeStoryController.to;

  @override
  void initState() {
    super.initState();
    ctr = new TabController(vsync: this, length: 2);

    freeWriteController.readIdeaAndTags();
    myLifeController.readMyStory();
  }

  @override
  void dispose() {
    super.dispose();
    ctr.dispose();
  }

  Widget myLifePage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: ListView.builder(
          itemCount: myLifeController.myLifeStory.length,
          itemBuilder: (context, index) {
            return Obx(
              () => Column(
                children: [
                  TextButton(
                    onPressed: () => print(myLifeController.myLifeStory[index].lifeMemo),
                    child: Text(myLifeController.myLifeStory[index].lifeMemo),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: '메모 가져오기',
        ),
      ),
      body: new TabBarView(
        controller: ctr,
        children: <Widget>[
          SearchBarView(isVisible: true, isEnabled: false),
          MyLifePageBody(),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.transparent,
        child: new TabBar(
          controller: ctr,
          tabs: <Tab>[
            new Tab(
              icon: Icon(Icons.book),
              child: Text('아이디어 메모'),
            ),
            new Tab(
              icon: Icon(Icons.calendar_today),
              child: Text('내 삶의 연표'),
            ),
          ],
        ),
      ),
    );
  }
}
