import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project_writer_v04/pages/common_parts/common_parts.dart';
import 'package:project_writer_v04/services/controller/character_controller.dart';

@immutable
class CharactersPage extends StatelessWidget {
  final characterController = CharactersController.to;
  final ScrollController scrollController = ScrollController();

  Widget nothingInMyLifeStory({BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '아직 캐릭터 카드가 없네요.\n새로운 캐릭터를 만들어 보세요 :)',
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
            onPressed: () => Navigator.of(context).pushNamed('/character_write_page'),
            child: Text('새로운 캐릭터 만들기'),
          ),
        ],
      ),
    );
  }

  Widget characterCards({CharactersController state, BuildContext context}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemCount: state.myCharacters.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  width: 250.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.more_vert,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              state.myCharacters[index].name,
                              style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 30.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                state.myCharacters[index].motivation,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: Text(
                                state.myCharacters[index].description,
                                style: TextStyle(fontSize: 28.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    characterController.readMyCharacters();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: BasicAppBar(
          appBarTitle: '캐릭터 만들기',
        ),
      ),
      body: GetBuilder<CharactersController>(
        builder: (controller) {
          return controller.myCharacters.isNotEmpty
              ? characterCards(context: context, state: controller)
              : nothingInMyLifeStory(context: context);
        },
      ),
    );
  }
}
