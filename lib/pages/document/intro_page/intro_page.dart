import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_doc_create_pop.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_parts.dart';
import 'package:project_writer_v04/pages/document/story_page/story_page.dart';
import 'package:project_writer_v04/services/controller/intro_page_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

class IntroPage extends StatelessWidget {
  final VoidCallback shouldLogOut;
  final AmplifyAuthCognito auth;

  IntroPage({Key key, this.shouldLogOut, this.auth}) : super(key: key);

  final introController = IntroDocumentController.to;

  Widget userInfo() {
    return Container();
  }

  Widget documentView({BuildContext context, IntroDocumentController state, int index}) {
    return Container(
      child: Stack(
        children: [
          IntroDocumentImage(
            imagePath: 'assets/images/basic_book_cover.jpg',
          ),
          Container(
            foregroundDecoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/basic_book_cover.jpg',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.document[index].docName,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'by',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      'Username',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(state.document[index].docDesc),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          IntroDocumentButton(
            index: index,
            documentId: introController.document[index].id,
            docName: introController.document[index].docName,
          ),
        ],
      ),
    );
  }

  Widget noteListView(BuildContext context) {
    introController.readDocument();
    return GetBuilder<IntroDocumentController>(
      builder: (controller) {
        if (controller.document.isNotEmpty) {
          return Container(
            child: CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height * 0.65,
                enableInfiniteScroll: false,
              ),
              itemCount: controller.document.length,
              itemBuilder: (context, itemIndex, realIdx) {
                return documentView(context: context, state: controller, index: itemIndex);
              },
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '아직 저장된\n데이터가 없습니다.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style.copyWith(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF3b4445)),
                    ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return DocCreatePopUp();
                      });
                },
                child: Text('새로운 스토리 만들기'),
              ),
            ],
          );
        }
      },
    );
  }

  //메뉴 리스트
  Widget bottomButtonList(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BasicMenuButton(
              icon: FontAwesomeIcons.fileAlt,
              buttonText: '자유롭게\n쓰기',
              onPressed: () => Navigator.of(context).pushNamed('/free_write_page'),
            ),
            BasicVerticalLine(),
            BasicMenuButton(
              icon: FontAwesomeIcons.calendar,
              buttonText: '내 삶의\n연표',
              onPressed: () => Navigator.of(context).pushNamed('/my_life_page'),
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
              onPressed: () => Navigator.of(context).pushNamed('/character_page'),
            ),
            BasicVerticalLine(),
            BasicMenuButton(
              icon: FontAwesomeIcons.sitemap,
              buttonText: '로그아웃\n임시',
              onPressed: () => shouldLogOut(),
            ),
          ],
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
                userInfo(),
                Expanded(child: noteListView(context)),
                bottomButtonList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
