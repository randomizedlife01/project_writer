import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_repository.dart';
import 'package:project_writer_v04/pages/document/free_write_page/free_write_page.dart';
import 'package:project_writer_v04/pages/document/intro_page/parts/intro_parts.dart';
import 'package:project_writer_v04/pages/document/timer_write_page/timer_write_page.dart';
import 'package:project_writer_v04/pages/document/free_write_page/bloc/free_write_cubit.dart';

class IntroPage extends StatelessWidget {
  final VoidCallback shouldLogOut;

  const IntroPage({Key key, this.shouldLogOut}) : super(key: key);

  Widget userInfo() {
    return Container();
  }

  Widget documentView(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
        horizontal: 40.0,
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          children: [
            IntroDocumentImage(
              imagePath: 'assets/images/basic_book_cover.jpg',
            ),
            Container(
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'lib/images/basic_book_cover3.jpg',
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
                      // Text(
                      //   snapshot.listValue[index].docName,
                      //   style: Theme.of(context).textTheme.headline1,
                      // ),
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
                      // Text(snapshot.listValue[index].docDesc),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IntroDocumentButton(),
          ],
        ),
      ),
    );
  }

  Widget noteListView() {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          height: 400.0,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0),
                  ));
            },
          );
        }).toList(),
      ),
    );
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
                    builder: (context) => BlocProvider<ReFreeCubit>(
                      create: (_) => ReFreeCubit(newCombineRepository: NewCombineRepository(), ideaMemo: [], searchHistory: []),
                      child: FreeWritePage(
                        appBarTitle: '자유롭게 쓰기',
                      ),
                    ),
                  ),
                ),
              ),
              BasicVerticalLine(),
              BasicMenuButton(
                icon: FontAwesomeIcons.calendar,
                buttonText: '내 삶의\n연표',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerWritePage(
                      appBarTitle: '타이머 글쓰기',
                    ),
                  ),
                ),
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
                userInfo(),
                Expanded(child: noteListView()),
                bottomButtonList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
