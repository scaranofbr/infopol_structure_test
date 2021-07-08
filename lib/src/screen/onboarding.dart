import 'package:flutter/material.dart';
import 'package:infopol_structure_test/src/model/login_response.dart';
import 'package:infopol_structure_test/src/screen/menu_list.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  final String token;
  final String cookie;
  final List<Menu> menus;

  const OnBoarding(this.token, this.cookie, this.menus, {Key? key})
      : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuList(
                            widget.token, widget.cookie, widget.menus)));
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Center(
                child: Text('FIRST!'),
              ),
              Center(
                child: Text('SECOND!'),
              ),
              Center(
                child: Text('THIRD!'),
              ),
            ],
            onPageChanged: (index) => _currentPageNotifier.value = index,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: CirclePageIndicator(
                  currentPageNotifier: _currentPageNotifier, itemCount: 3),
            ),
          )
        ],
      ),
    );
  }
}
