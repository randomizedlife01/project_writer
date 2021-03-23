import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/free_write_page.dart';

class IntroPage extends StatelessWidget {
  final VoidCallback shouldLogOut;

  const IntroPage({Key key, this.shouldLogOut}) : super(key: key);

  Widget noteListView() {
    return Container();
  }

  //메뉴 리스트
  Widget bottomButtonList(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BasicMenuButton(
                icon: FontAwesomeIcons.fileAlt,
                buttonText: '자유롭게\n쓰기',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FreeWritePage(
                      appBarTitle: '자유롭게 쓰기',
                    ),
                  ),
                ),
              ),
              BasicVerticalLine(),
              BasicMenuButton(
                icon: FontAwesomeIcons.calendar,
                buttonText: '내 삶의\n연표',
                onPressed: () {},
              ),
              BasicVerticalLine(),
              BasicMenuButton(
                icon: FontAwesomeIcons.stopwatch,
                buttonText: '타이머\n글쓰기',
                onPressed: () {},
              ),
              BasicVerticalLine(),
              BasicMenuButton(
                icon: FontAwesomeIcons.users,
                buttonText: '캐릭터\n만들기',
                onPressed: () {},
              ),
              BasicVerticalLine(),
              BasicMenuButton(
                icon: FontAwesomeIcons.sitemap,
                buttonText: '마인드맵\n작성',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                bottomButtonList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
