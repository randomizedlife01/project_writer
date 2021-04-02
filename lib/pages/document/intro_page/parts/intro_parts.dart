import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

//도큐멘트 위의 버
class IntroDocumentButton extends StatelessWidget {
  //도튜멘트 팝업 메뉴버튼
  List<UnicornButton> docMenuButtons() {
    var docMenuButton = [];

    docMenuButton.add(
      UnicornButton(
        hasLabel: true,
        labelText: "스토리 속으로",
        currentButton: FloatingActionButton(
          heroTag: "doc-add",
          backgroundColor: Color(0xFFF8FEE9),
          mini: true,
          child: Icon(
            FontAwesomeIcons.book,
            color: Color(0xFF252a34),
            size: 16.0,
          ),
          onPressed: () {
            //TODO: 스토리 속으로
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MultiBlocProvider(
            //       providers: [
            //         BlocProvider<SummaryCubit>(
            //           create: (context) => SummaryCubit(snapshot.listValue[index].id)..getSummaries(),
            //         ),
            //         BlocProvider<EditCubit>(
            //           create: (context) => EditCubit()..editDisabled(),
            //         ),
            //       ],
            //       child: StoryPage(
            //         getDocId: snapshot.listValue[index].id,
            //         getDocName: snapshot.listValue[index].docName,
            //       ),
            //     ),
            //   ),
            // );
          },
        ),
        labelBackgroundColor: Colors.transparent,
        labelColor: Color(0xFFF8FEE9),
        labelHasShadow: false,
      ),
    );
    docMenuButton.add(
      UnicornButton(
        hasLabel: true,
        labelText: "표지 편집",
        currentButton: FloatingActionButton(
          heroTag: "doc-edit",
          backgroundColor: Color(0xFFF8FEE9),
          mini: true,
          child: Icon(
            FontAwesomeIcons.edit,
            color: Color(0xFF252a34),
            size: 16.0,
          ),
          onPressed: () {
            //TODO: 표지 편집.
            //print('edit button : ${snapshot.listValue[index].id}');
          },
        ),
        labelBackgroundColor: Colors.transparent,
        labelColor: Color(0xFFF8FEE9),
        labelHasShadow: false,
      ),
    );
    docMenuButton.add(
      UnicornButton(
        hasLabel: true,
        labelText: "문서 삭제",
        currentButton: FloatingActionButton(
          heroTag: "doc-delete",
          backgroundColor: Color(0xFFF8FEE9),
          mini: true,
          child: Icon(
            FontAwesomeIcons.trashAlt,
            color: Color(0xFFe23e57),
            size: 16.0,
          ),
          onPressed: () {
            //TODO: 문서 지우기
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return DocDeletePopUp(
            //       index: index,
            //       documentId: snapshot.listValue[index].id,
            //     );
            //   },
            // );
          },
        ),
        labelBackgroundColor: Colors.transparent,
        labelColor: Color(0xFFe23e57),
        labelHasShadow: false,
      ),
    );

    return docMenuButton;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8.0,
      bottom: 8.0,
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: UnicornDialer(
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
              orientation: UnicornOrientation.VERTICAL,
              parentButton: Icon(
                Icons.list,
              ),
              childButtons: docMenuButtons()),
        ),
      ),
    );
  }
}

class IntroDocumentImage extends StatelessWidget {
  final String imagePath;

  const IntroDocumentImage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imagePath,
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
    );
  }
}
