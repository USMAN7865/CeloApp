import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Auth/SignInPage.dart';
import 'package:flutter_diet_tips/Appetotor/customWidget/videowidget.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';

class MenuFrame extends StatelessWidget {
  PageController pageController = PageController();
  Duration _animationDuration = Duration(milliseconds: 500);

  void _changePage(int page) {
    pageController.animateToPage(page,
        duration: _animationDuration, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Appetitor".toUpperCase(),
          style: TextStyle(color: primaryColor, letterSpacing: 2),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SignInPage();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 4, bottom: 4),
              child: Container(
                height: 10,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primaryColor, width: 2)),
                child: Text(
                  "Sign IN".toUpperCase(),
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          VideoWidget(),
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'MEAL PLANS FOR BUSY PEOPLE',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Oue Meal Plans are cooked with Love & Portioned to suit your body , fitness goals and taste buds',
                        maxLines: 3,
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: <Widget>[],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignInPage();
                      }));
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(color: primaryColor),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                final action = CupertinoActionSheet(
                                  message: Text(
                                    'Choose your Country',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 100,
                                              width: 120,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'Saudi Arabia',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 100,
                                              width: 120,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'Bahrain',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 100,
                                              width: 120,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'UAE',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 100,
                                              width: 120,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'Kuwait',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 100,
                                              width: 120,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'Qatar',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 100,
                                              width: 120,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'Oman',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );

                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => action);
                              },
                              icon: Icon(
                                FontAwesomeIcons.flag,
                                color: primaryColor,
                              )),
                          IconButton(
                              onPressed: () {
                                final action = CupertinoActionSheet(
                                  message: Text(
                                    'Choose your Country',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 70,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'Arabic',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              height: 70,
                                              child: CupertinoActionSheetAction(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Icon(
                                                            Icons.language)),
                                                    Expanded(
                                                      child: Text(
                                                        'English',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isDefaultAction: true,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );

                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => action);
                              },
                              icon: Icon(
                                Icons.language,
                                color: primaryColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
