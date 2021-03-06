import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_doc_create_pop.dart';
import 'package:project_writer_v04/pages/document/intro_page/component/intro_parts.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';
import 'package:project_writer_v04/services/controller/free_write_controller.dart';
import 'package:project_writer_v04/services/controller/intro_page_controller.dart';
import 'package:project_writer_v04/services/controller/my_life_controller.dart';
import 'package:project_writer_v04/services/controller/story_summary_controller.dart';

class IntroPage extends StatefulWidget {
  final VoidCallback shouldLogOut;
  final AmplifyAuthCognito auth;

  IntroPage({Key key, this.shouldLogOut, this.auth}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introController = IntroDocumentController.to;

  Widget userInfo() {
    return Container();
  }

  Widget documentView({BuildContext context, IntroDocumentController state, int index}) {
    return Container(
      color: Color(0xFFebe4db),
      child: Stack(
        children: [
          // IntroDocumentImage(
          //   imagePath: 'assets/images/basic_book_cover.jpg',
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF1D407F), width: 4.0),
              color: Colors.transparent, //add it here
            ),
            // foregroundDecoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //       'assets/images/basic_book_cover.jpg',
            //     ),
            //     fit: BoxFit.cover,
            //   ),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.5),
            //       spreadRadius: 2,
            //       blurRadius: 5,
            //       offset: Offset(5, 5),
            //     ),
            //   ],
            // ),
            // alignment: Alignment.center,
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.document[index].docName,
                      style: Theme.of(context).textTheme.headline1.copyWith(color: Color(0xFF1D407F)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'by',
                      style: Theme.of(context).textTheme.headline2.copyWith(color: Color(0xFF1D407F)),
                    ),
                    Text(
                      'Username',
                      style: Theme.of(context).textTheme.headline2.copyWith(color: Color(0xFF1D407F)),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            state.document[index].docDesc,
                            style: Theme.of(context).textTheme.subtitle1.copyWith(color: Color(0xFF1D407F)),
                          ),
                        ),
                      ),
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
            color: Colors.transparent,
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
                  '?????? ?????????\n???????????? ????????????.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style.copyWith(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFebe4db)),
                    ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return DocCreatePopUp();
                      });
                },
                child: Text('????????? ????????? ?????????'),
              ),
            ],
          );
        }
      },
    );
  }

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
              buttonText: '????????????\n??????',
              onPressed: () => Navigator.of(context).pushNamed('/free_write_page'),
            ),
            BasicVerticalLine(indent: 40.0, endIndent: 40.0, width: 8.0),
            BasicMenuButton(
              icon: FontAwesomeIcons.calendar,
              buttonText: '??? ??????\n??????',
              onPressed: () => Navigator.of(context).pushNamed('/my_life_page'),
            ),
            BasicVerticalLine(indent: 40.0, endIndent: 40.0, width: 8.0),
            BasicMenuButton(
              icon: FontAwesomeIcons.stopwatch,
              buttonText: '?????????\n?????????',
              onPressed: () {},
            ),
            BasicVerticalLine(indent: 40.0, endIndent: 40.0, width: 8.0),
            BasicMenuButton(
              icon: FontAwesomeIcons.users,
              buttonText: '?????????\n?????????',
              onPressed: () => Navigator.of(context).pushNamed('/character_page'),
            ),
            BasicVerticalLine(indent: 40.0, endIndent: 40.0, width: 8.0),
            BasicMenuButton(
              icon: FontAwesomeIcons.sitemap,
              buttonText: '????????????\n??????',
              onPressed: () => widget.auth.signOut(request: null),
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton({
    String buttonName,
    BuildContext context,
    IconData icon,
    CrossAxisAlignment crossAlignment,
    MainAxisAlignment mainAxisAlignment,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF111f4d)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAlignment,
            children: [
              Icon(
                icon,
                size: 15.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                buttonName,
                style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget backLayout(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                backButton(
                  buttonName: '???????????? ??????',
                  context: context,
                  icon: FontAwesomeIcons.fileAlt,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAlignment: CrossAxisAlignment.start,
                ),
                backButton(
                  buttonName: '??? ?????? ??????',
                  context: context,
                  icon: FontAwesomeIcons.calendar,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF111f4d)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF111f4d)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                backButton(
                  buttonName: '????????? ?????????',
                  context: context,
                  icon: FontAwesomeIcons.users,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAlignment: CrossAxisAlignment.start,
                ),
                backButton(
                  buttonName: '??????(?????????)',
                  context: context,
                  icon: FontAwesomeIcons.cog,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAlignment: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.put(FreeWriteController());
    Get.put(CharactersController());
    Get.put(IntroDocumentController());
    Get.put(MyLifeStoryController());
    Get.put(StorySummaryController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
    );
  }
}
