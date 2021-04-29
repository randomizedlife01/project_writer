import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//기본 메뉴 버튼
class BasicMenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String buttonText;

  const BasicMenuButton({Key key, this.onPressed, this.icon, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0.0),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(12.0, 12.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 18.0,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

//기본 앱 바
class BasicAppBar extends StatelessWidget {
  final String appBarTitle;

  const BasicAppBar({Key key, this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400, fontSize: 20.0),
      ),
    );
  }
}

//기본 우하단 플로팅 버튼
class BasicFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const BasicFloatingButton({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Center(
          child: Container(
            width: 50,
            height: 50,
            child: Icon(
              icon,
              size: 40.0,
              color: Color(0xFF111f4d),
            ),
            // decoration: BoxDecoration(
            //   color: Color(0xFF111f4d),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(40),
            //   ),
            //   // boxShadow: [
            //   //   BoxShadow(
            //   //     color: Color(0xFF181c1c),
            //   //     offset: Offset(4.0, 4.0),
            //   //     blurRadius: 15.0,
            //   //     spreadRadius: 1.0,
            //   //   ),
            //   //   BoxShadow(
            //   //     color: Color(0xFF596769),
            //   //     offset: Offset(-4.0, -4.0),
            //   //     blurRadius: 15.0,
            //   //     spreadRadius: 1.0,
            //   //   ),
            //   // ],
            // ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
    );
  }
}

//버튼 가로 리스트 나눌 때 선
class BasicVerticalLine extends StatelessWidget {
  final double indent;
  final double endIndent;
  final double width;

  const BasicVerticalLine({Key key, this.indent, this.endIndent, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      indent: indent,
      endIndent: endIndent,
      color: Color(0xFF020205),
      width: width,
    );
  }
}

class DocInputForm extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final bool autoFocus;
  final VoidCallback onTap;
  final Function validator;

  const DocInputForm({
    Key key,
    this.hintText,
    this.labelText,
    this.controller,
    this.autoFocus = true,
    this.onTap,
    this.validator,
  }) : super(key: key);

  Widget inputForm({String hintText, String labelText, TextEditingController controller}) {
    return TextFormField(
      maxLines: null,
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
        fontSize: 12.0,
        fontFamily: 'GothicA1',
        color: Color(0xFF252a34),
        fontWeight: FontWeight.w600,
      ),
      onTap: onTap,
      autofocus: autoFocus,
      autocorrect: false,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF020205),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF020205),
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.0,
          fontFamily: 'GothicA1',
          color: Color(0xff8785a2),
          fontWeight: FontWeight.w600,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 12.0,
          fontFamily: 'GothicA1',
          color: Color(0xFF34346F),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return inputForm(hintText: hintText, labelText: labelText, controller: controller);
  }
}

class DropDownButtons extends StatelessWidget {
  final BuildContext context;
  final String getDocId;

  final VoidCallback onAddDetailTap;
  final VoidCallback onImportTap;
  final VoidCallback onDeleteTap;

  const DropDownButtons({Key key, this.onAddDetailTap, this.onImportTap, this.context, this.getDocId, this.onDeleteTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DocNormalButton(
              icon: FontAwesomeIcons.arrowsAltH,
              buttonName: '스토리 만들기',
              onPressed: onAddDetailTap,
            ),
            Container(
              height: 30.0,
              child: VerticalDivider(
                width: 1.0,
                color: Color(0xFF8785a2),
              ),
            ),
            DocNormalButton(
              icon: FontAwesomeIcons.plus,
              buttonName: '메모 가져오기',
              onPressed: onImportTap,
            ),
            Container(
              height: 30.0,
              child: VerticalDivider(
                width: 1.0,
                color: Color(0xFF8785a2),
              ),
            ),
            DocNormalButton(
              icon: FontAwesomeIcons.minus,
              buttonName: '메모/스토리 삭제',
              onPressed: onDeleteTap,
            ),
          ],
        ),
      ],
    );
  }
}

class AddButtonBar extends StatelessWidget {
  final BuildContext context;
  final String getDocId;
  final ScrollController scrollController;

  final VoidCallback onAddSentenceTap;
  final VoidCallback onAddTalkTap;
  final VoidCallback onImportTap;
  final VoidCallback onSwitchingTap;

  const AddButtonBar({
    Key key,
    this.getDocId,
    this.scrollController,
    this.context,
    this.onAddSentenceTap,
    this.onAddTalkTap,
    this.onImportTap,
    this.onSwitchingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DocNormalButton(
              icon: FontAwesomeIcons.solidCircle,
              buttonName: '문장 추가',
              onPressed: onAddSentenceTap,
            ),
            Container(
              height: 30.0,
              child: VerticalDivider(
                width: 1.0,
                color: Color(0xFF8785a2),
              ),
            ),
            DocNormalButton(
              icon: FontAwesomeIcons.quoteRight,
              buttonName: '대화 추가',
              onPressed: onAddTalkTap,
            ),
            Container(
              height: 30.0,
              child: VerticalDivider(
                width: 1.0,
                color: Color(0xFF8785a2),
              ),
            ),
            DocNormalButton(
              icon: FontAwesomeIcons.ellipsisH,
              buttonName: '문장 가져오기',
              onPressed: onImportTap,
            ),
            Container(
              height: 30.0,
              child: VerticalDivider(
                width: 1.0,
                color: Color(0xFF8785a2),
              ),
            ),
            DocNormalButton(
              icon: FontAwesomeIcons.toggleOn,
              buttonName: '요약/스토리',
              onPressed: onSwitchingTap,
            ),
          ],
        ),
      ],
    );
  }
}

class DocNormalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String buttonName;

  const DocNormalButton({Key key, this.onPressed, this.icon, this.buttonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          FaIcon(
            icon,
            size: 20.0,
            color: Color(0xFF111f4d),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            buttonName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'GothicA1',
              fontWeight: FontWeight.w500,
              color: Color(0xFF111f4d),
            ),
          ),
        ],
      ),
    );
  }
}

class DeletePopup extends StatelessWidget {
  final String id;
  final VoidCallback delete;

  const DeletePopup({Key key, this.id, this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '정말로 요약과 스토리를\n삭제하시겠습니까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'GothicA1',
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFe23e57),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '이 작업은 되돌릴 수 없습니다',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'GothicA1',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF020205),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              child: Text('취 소'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              child: Text("삭 제"),
                              onPressed: delete,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
