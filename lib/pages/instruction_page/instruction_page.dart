import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructionPage extends StatefulWidget {
  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _initInstructionEnabled();
  }

  _initInstructionEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEnabled = prefs.getBool('instructionEnabled') ?? true;
    print('Instruction Enabled : $isEnabled');
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushNamed('/intro_page');
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  _setInstructionEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEnabled = prefs.getBool('instructionEnabled') ?? true;
    print('Instruction Enabled : $isEnabled');
    await prefs.setBool('instructionEnabled', !isEnabled);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      titlePadding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
      descriptionPadding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
      pageColor: Color(0xFFebe4db),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color(0xFFebe4db),
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            //child: _buildImage('flutter.png', 100),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                checkColor: Color(0xFFebe4db), // color of tick Mark
                activeColor: Color(0xFF111f4d),
                value: isEnabled,
                onChanged: (value) {
                  setState(() {
                    _setInstructionEnabled();
                  });
                },
              ),
              Expanded(
                child: Text('이 페이지를 다시 보지 않습니다'),
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => _onIntroEnd(context),
              ),
            ],
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "상상 노트",
          body: "떠오르는 모든 상상을 적어보세요!\n태그와 함께 작성하고 검색하여\n스토리에 사용할 수 있습니다.",
          //image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "상상 노트",
          body: "떠오르는 모든 상상을 적어보세요!\n태그와 함께 작성하고 검색하여\n스토리에 사용할 수 있습니다.",
          //image: _buildImage('img1.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "내 연표 만들기",
          body: "많은 이야기들이\n나로부터 시작됩니다.\n내 삶의 연표를\n만들어보는 것은 어떨까요?",
          //image: _buildImage('img2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "캐릭터 만들기",
          body: "내 주변 사람들을 모티브 삼아\n캐릭터를 만들어볼까요? \n대화를 만들 때\n쉽게 작성할 수 있습니다.",
          //image: _buildImage('img3.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Full Screen Page",
          body:
              "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          //image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 4,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          //image: _buildImage('img2.jpg'),
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Title of last page - reversed",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 4,
            imageFlex: 4,
            bodyAlignment: Alignment.center,
            imageAlignment: Alignment.topCenter,
          ),
          //image: _buildImage('img1.jpg'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('건너뛰기'),
      next: const Icon(
        Icons.arrow_forward,
        color: Color(0xFF020205),
      ),
      done: const Text('완료', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF020205))),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFF111f4d),
        activeColor: Color(0xFF020205),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
