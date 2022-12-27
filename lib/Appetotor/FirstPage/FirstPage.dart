import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Map/mapIntegration.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Packages/package.dart';
import 'package:flutter_diet_tips/CreatePlanPage.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/Getuserdata.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:flutter_diet_tips/util/ConstantWidget.dart';
import 'package:flutter_diet_tips/util/DataFile.dart';
import 'package:flutter_diet_tips/util/PrefData.dart';
import 'package:flutter_diet_tips/util/SizeConfig.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/l10n.dart';
import '../../model/DietModel.dart';

class FirstPage extends StatefulWidget {
  // final ValueChanged<bool> onChanged;

  // FirstPage(this.onChanged);

  @override
  _FirstPage createState() {
    return _FirstPage();
    // return _FirstPage(this.onChanged);
  }
}

class _FirstPage extends State<FirstPage> {
  String? gender;
  String? motive;
  String? userage;
  double? height;
  String? weight;
  String? goalweight;
  String? currentdietplan;
  String? exceptfood;

  int _position = 0;
  int _dietPosition = 0;
  int _itemPosition = 0;
  int _itemAboutPosition = 0;
  int _motivatePosition = 0;
  int _variedPosition = 0;
  double tabHeight = 0;
  double tabWidth = 0;
  double tabRadius = 0;
  double? margin;
  bool isCm = true;
  bool isKg = true;

  String? currentusertoken;

  loadtoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentusertoken = (prefs.getString('token') ?? '');
      print(currentusertoken);
    });
  }

  List<String> selectMealList = [];
  List<DietModel> mealList = DataFile.getMealList();
  List<DietModel> dietList = DataFile.getDietList();
  List<DietModel> motivateList = DataFile.getMotivateList();
  List<DietModel> variedList = DataFile.getVariedList();
  List<String> itemList = ["Chicken", "Wheat", "Peanut", "Soy", "Eggs"];
  List<String> hearAboutList = [
    "In social media ad",
    "From a person I follow",
    "From my friend",
    "On TV",
    "On the radio",
    "Other"
  ];

  TextEditingController textEditingControllercm = new TextEditingController();
  TextEditingController textEditingControllerfit = new TextEditingController();
  TextEditingController textEditingControllerInch = new TextEditingController();

  bool isMale = true;

  int cm = 80;
  int inch = 25;
  int ft = 25;
  int kg = 25;
  int age = 22;
  double lbs = 25;

  Future<bool> _requestPop() {
    if (_position > 0) {
      setState(() {
        _position--;
      });
    } else {
      if (Platform.isIOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
      // Future.delayed(const Duration(milliseconds: 200), () {
      //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      // });
    }

    return new Future.value(false);
  }

  // int totalPosition = 6;

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();
    loadtoken();
    setLbsValue();
  }

  setLbsValue() {
    lbs = kg * 2.205;
    lbs = double.parse((lbs).toStringAsFixed(0));

    double total = (cm / 2.54);
    double value = (total / 12);
    double value1 = (total - 12) * value.toInt();

    print("total----$total------$value--------$value1");

    ft = value.toInt();
    inch = value1.toInt();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    double defMargin = getScreenPercentSize(context, 2);

    margin = getScreenPercentSize(context, 2);
    if (widgetList.length <= 0) {
      getPositionWidget(context);
    }

    setState(() {});

    return WillPopScope(
        child: Scaffold(
          backgroundColor: cellColor,
          appBar: _position == 11
              ? null
              : AppBar(
                  backgroundColor: cellColor,
                  elevation: 0,
                  title: Text(""),
                  leading: IconButton(
                    icon: Icon(
                      Icons.keyboard_backspace_sharp,
                      color: textColor,
                    ),
                    onPressed: _requestPop,
                  ),
                ),
          body: Stack(
            children: [
              Container(
                // child:getHearAboutUsDiet(),
                child:
                    widgetList.length > 0 ? widgetList[_position] : Container(),
              ),
              _position == 11
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: defMargin),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          child: Container(
                              height: getScreenPercentSize(context, 7),
                              margin: EdgeInsets.only(bottom: (defMargin * 2)),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular((defMargin / 2)))),
                              child: InkWell(
                                child: Center(
                                  child: getCustomTextWithoutAlign(
                                      S.of(context).continueText,
                                      Colors.white,
                                      FontWeight.w500,
                                      ConstantData.font22Px),
                                ),
                              )),
                          onTap: () {
                            if (_position < (widgetList.length - 1)) {
                              _position++;
                              print(_position);

                              setState(() {
                                if (_position == 1) {
                                  print(gender);

                                  context
                                      .read<GetUserDataProvider>()
                                      .setUsergender(gender ?? "Male");
                                } else if (_position == 2) {
                                  print(motive);

                                  context
                                      .read<GetUserDataProvider>()
                                      .setUsermotive(
                                          motive ?? "Feeling Confident");
                                  ;
                                } else if (_position == 3) {
                                  print(userage);
                                  context
                                      .read<GetUserDataProvider>()
                                      .setUserage(userage ?? "22");
                                  ;
                                } else if (_position == 4) {
                                  print(height.toString());
                                  context
                                      .read<GetUserDataProvider>()
                                      .setUserheight(180.0);
                                  ;
                                } else if (_position == 5) {
                                  print(height.toString());
                                  context
                                      .read<GetUserDataProvider>()
                                      .setUserweight(180.0);
                                  ;
                                } else if (_position == 5) {
                                  print(height.toString());
                                  context
                                      .read<GetUserDataProvider>()
                                      .setUsertargetweight(180.0);
                                  ;
                                } else if (_position == 5) {
                                  print(height.toString());
                                  context
                                      .read<GetUserDataProvider>()
                                      .setUsercurrrentplan(
                                          currentdietplan ?? "Standard");
                                  ;
                                } else if (_position == 6) {
                                  print(height.toString());
                                  context
                                      .read<GetUserDataProvider>()
                                      .setUserexceptfood(
                                          exceptfood ?? "Standard");
                                  ;
                                } else if (_position == 8) {
                                  PostUserData();
                                }
                              });
                            } else {
                              PrefData.setIsFirstTime(false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreatePlanPage(),
                                  ));
                            }
                          },
                        ),
                      )),
              Container(
                height: getScreenPercentSize(context, 0.7),
                child: Row(
                  children: [
                    for (int i = 0; i < widgetList.length; i++)
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          color: (i <= _position)
                              ? primaryColor
                              : Colors.grey.shade200,
                          height: double.infinity,
                        ),
                        flex: 1,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        onWillPop: _requestPop);
  }

  getPositionWidget(BuildContext context) {
    widgetList.add(firstWidget(context));
    widgetList.add(getMotivates());
    widgetList.add(ageWidget());
    widgetList.add(heightWidget());
    widgetList.add(weightWidget());
    widgetList.add(goalWeightWidget());
    widgetList.add(getCurrentDiet());
    widgetList.add(getSearchDiet());
    widgetList.add(getMealDiet());
    widgetList.add(getVaried());
    widgetList.add(getHearAboutUsDiet());
    widgetList.add(MapIntegration());
 
  }

  Widget getHearAboutUsDiet() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("Where did you hear\nabout us?"),
            Expanded(
              child: ListView.separated(
                itemCount: hearAboutList.length,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) {
                  return Container(
                    color: subTextColor.withOpacity(0.1),
                    height: 0.5,
                  );
                },
                itemBuilder: (context, index) {
                  bool isSelect = (index == _itemAboutPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _itemAboutPosition = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: (margin! / 2)),
                      padding: EdgeInsets.symmetric(vertical: (margin!)),
                      child: Row(
                        children: [
                          // SizedBox(
                          //   width: margin,
                          // ),

                          Expanded(
                            child: getTextWidget(
                                hearAboutList[index],
                                textColor,
                                TextAlign.start,
                                FontWeight.bold,
                                getScreenPercentSize(context, 1.8)),
                          ),

                          Icon(
                            (isSelect) ? Icons.check_circle : Icons.circle,
                            color: isSelect
                                ? primaryColor
                                : subTextColor.withOpacity(0.1),
                            size: getScreenPercentSize(context, 4),
                          ),

                          // SizedBox(width: margin,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getSearchDiet() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("Select items that\nyou don't eat!"),
            Expanded(
              child: ListView.separated(
                itemCount: itemList.length,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) {
                  return Container(
                    color: subTextColor.withOpacity(0.1),
                    height: 0.5,
                  );
                },
                itemBuilder: (context, index) {
                  bool isSelect = (index == _itemPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _itemPosition = index;
                        print(_itemPosition);

                        if (_itemPosition == 0) {
                          exceptfood = "Standard";
                        } else if (_itemPosition == 1) {
                          exceptfood = "Vegterian";
                        } else if (_itemPosition == 1) {
                          exceptfood = "Vegan";
                        } else if (_itemPosition == 1) {
                          exceptfood = "Pescatarian";
                        } else if (_itemPosition == 1) {
                          exceptfood = "Gluten-Free";
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(vertical: (margin!)),
                      child: Row(
                        children: [
                          Expanded(
                            child: getTextWidget(
                                dietList[index].title!,
                                textColor,
                                TextAlign.start,
                                FontWeight.bold,
                                getScreenPercentSize(context, 1.8)),
                          ),

                          Icon(
                            (isSelect) ? Icons.check_circle : Icons.circle,
                            color: isSelect
                                ? primaryColor
                                : subTextColor.withOpacity(0.1),
                            size: getScreenPercentSize(context, 4),
                          ),

                          // SizedBox(width: margin,)
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMealDiet() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("Which meals do you \nusually have?"),
            Expanded(
              child: ListView.builder(
                itemCount: mealList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (selectMealList.contains(index.toString()));
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (!selectMealList.contains(index.toString())) {
                          selectMealList.add(index.toString());
                        } else {
                          selectMealList.remove(index.toString());
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            ConstantData.assetsPath + mealList[index].image!,
                            height: getScreenPercentSize(context, 4),
                          ),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: getTextWidget(
                                mealList[index].title!,
                                textColor,
                                TextAlign.start,
                                FontWeight.bold,
                                getScreenPercentSize(context, 1.8)),
                          ),
                          Icon(
                            (isSelect) ? Icons.check_circle : Icons.circle,
                            color: isSelect
                                ? primaryColor
                                : subTextColor.withOpacity(0.1),
                            size: getScreenPercentSize(context, 4),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getCurrentDiet() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("Are you currently\nfollowing a diet?"),
            Expanded(
              child: ListView.builder(
                itemCount: dietList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == _dietPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _dietPosition = index;
                        print(_dietPosition);
                        if (_dietPosition == 0) {
                          currentdietplan = "Standard";
                        } else if (_dietPosition == 1) {
                          currentdietplan = "Vegterian";
                        } else if (_dietPosition == 1) {
                          currentdietplan = "Vegan";
                        } else if (_dietPosition == 1) {
                          currentdietplan = "Pescatarian";
                        } else if (_dietPosition == 1) {
                          currentdietplan = "Gluten-Free";
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          color: isSelect ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: isSelect
                                  ? Colors.transparent
                                  : subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            ConstantData.assetsPath + dietList[index].image!,
                            height: getScreenPercentSize(context, 4),
                          ),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    dietList[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 1.8)),
                                getTextWidget(
                                    dietList[index].subTitle!,
                                    isSelect ? Colors.white : Colors.grey,
                                    TextAlign.start,
                                    FontWeight.w500,
                                    getScreenPercentSize(context, 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMotivates() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("What motives you\nthe most?"),
            Expanded(
              child: ListView.builder(
                itemCount: motivateList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == _motivatePosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _motivatePosition = index;
                        print(index);

                        if (index == 0) {
                          motive = "Feeling Confident";
                          context
                              .read<GetUserDataProvider>()
                              .setUsermotive("Feeling Confident");
                        } else if (index == 1) {
                          motive = "Being Noticed";
                        } else if (index == 2) {
                          motive = "Being Active";
                        } else if (index == 3) {
                          motive = "Gaining Muscle";
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          color: isSelect ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: isSelect
                                  ? Colors.transparent
                                  : subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          Image.asset(
                            ConstantData.assetsPath +
                                motivateList[index].image!,
                            height: getScreenPercentSize(context, 4),
                          ),
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    motivateList[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 1.8)),
                                getTextWidget(
                                    motivateList[index].subTitle!,
                                    isSelect ? Colors.white : Colors.grey,
                                    TextAlign.start,
                                    FontWeight.w500,
                                    getScreenPercentSize(context, 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getVaried() {
    SizeConfig().init(context);

    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(margin!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderText("How varied do you\nwant your diet to be?"),
            Expanded(
              child: ListView.builder(
                itemCount: variedList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  bool isSelect = (index == _variedPosition);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _variedPosition = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: (margin! / 2)),
                      padding: EdgeInsets.symmetric(
                          horizontal: (margin!), vertical: (margin!)),
                      decoration: BoxDecoration(
                          color: isSelect ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(
                              getScreenPercentSize(context, 1.5))),
                          border: Border.all(
                              color: isSelect
                                  ? Colors.transparent
                                  : subTextColor.withOpacity(0.1),
                              width: 1.5)),
                      child: Row(
                        children: [
                          SizedBox(
                            width: margin,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getTextWidget(
                                    variedList[index].title!,
                                    isSelect ? Colors.white : textColor,
                                    TextAlign.start,
                                    FontWeight.bold,
                                    getScreenPercentSize(context, 1.8)),
                                getTextWidget(
                                    variedList[index].subTitle!,
                                    isSelect ? Colors.white : Colors.grey,
                                    TextAlign.start,
                                    FontWeight.w500,
                                    getScreenPercentSize(context, 1.5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  getHeaderView(String s, String subTitle) {
    Widget space = SizedBox(
      height: margin,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        space,
        getTitleWidget(s),
        space,
        getSubTitleWidget(subTitle),
      ],
    );
  }

  getTitleWidget(String s) {
    return getTextWidget(s, Colors.black, TextAlign.start, FontWeight.bold,
        getScreenPercentSize(context, 2.5));
  }

  getSubTitleWidget(String s) {
    return getTextWidget(s, Colors.grey, TextAlign.start, FontWeight.w300,
        getScreenPercentSize(context, 1.8));
  }

  Widget heightWidget() {
    TextEditingController textEditingController =
        new TextEditingController(text: cm.toString());
    TextEditingController textEditingController1 =
        new TextEditingController(text: ft.toString());
    TextEditingController textEditingControllerInch =
        new TextEditingController(text: inch.toString());

    return StatefulBuilder(
      builder: (context, setState) => Container(
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              S.of(context).howTallAreYou,
            ),
            Container(
              margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (margin!)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: getTextField((isCm)
                                ? textEditingController
                                : textEditingController1),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          getTextWidget(
                              (isCm) ? "Cm" : "Ft",
                              subTextColor,
                              TextAlign.end,
                              FontWeight.w600,
                              getScreenPercentSize(context, 2)),
                          SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: (!isCm),
                            child: IntrinsicWidth(
                              child: getTextField(textEditingControllerInch),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Visibility(
                            visible: (!isCm),
                            child: getTextWidget(
                                "In",
                                subTextColor,
                                TextAlign.end,
                                FontWeight.w600,
                                getScreenPercentSize(context, 2)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  getTabWidget(setState)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getTextField(TextEditingController editingController) {
    return TextField(
        onChanged: (value) {
          setState(() {
            textEditingControllercm.text = editingController.text;
            textEditingControllerfit.text = editingController.text;
            textEditingControllerInch.text = editingController.text;

            height = double.parse(editingController.text);
            print(editingController.text);
          });
        },
        maxLines: 1,
        controller: editingController,
        cursorColor: primaryColor,
        textAlign: TextAlign.end,
        textAlignVertical: TextAlignVertical.bottom,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(3),
        ],
        style: TextStyle(
            color: textColor,
            fontSize: getScreenPercentSize(context, 6),
            fontFamily: ConstantData.fontFamily,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            fillColor: Colors.red,
            filled: false,
            hintText: "0",
            border: InputBorder.none,
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: getScreenPercentSize(context, 6),
                fontFamily: ConstantData.fontFamily,
                fontWeight: FontWeight.w500)));
  }

  getTab1(bool isRight, String s, bool isSelect, Function function) {
    tabWidth = getWidthPercentSize(context, 25);
    tabHeight = getScreenPercentSize(context, 6);
    tabRadius = getPercentSize(tabHeight, 50);

    var radius = Radius.circular(tabRadius);
    var radius1 = Radius.circular(0);
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        width: tabWidth,
        height: tabHeight,
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    (isSelect) ? primaryColor : subTextColor.withOpacity(0.1),
                width: getPercentSize(tabHeight, 3)),
            borderRadius: BorderRadius.only(
              topLeft: (isRight) ? radius1 : radius,
              bottomLeft: (isRight) ? radius1 : radius,
              topRight: (isRight) ? radius : radius1,
              bottomRight: (isRight) ? radius : radius1,
            )),
        child: Center(
          child: getTextWidget(s, (isSelect) ? primaryColor : subTextColor,
              TextAlign.center, FontWeight.w600, getPercentSize(tabWidth, 16)),
        ),
      ),
    );
  }

  getTabWidget(var setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTab1(false, "Ft", !isCm, () {
          setState(() {
            isCm = false;
            //   context.read<GetUserDataProvider>().setUserheight(value);
          });
        }),
        getTab1(true, "Cm", isCm, () {
          setState(() {
            isCm = true; 
          });
        }), 
      ],
    );
  }

  getWeightTabWidget(var setState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTab1(false, "lb", !isKg, () {
          setState(() {
            isKg = false;
          });
        }),
        getTab1(true, "Kg", isKg, (value) {
          setState(() {
            isKg = true;
          });
        }), 
      ],
    );
  }

  Widget ageWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        color: cellColor,
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              "How old are you?",
            ),
            Align(
              alignment: Alignment.center,
              child: NumberPicker(
                value: age,
                itemHeight: getScreenPercentSize(context, 12),
                minValue: 18,
                maxValue: 350,
                textStyle: TextStyle(
                    fontSize: getScreenPercentSize(context, 5),
                    color: Colors.black,
                    fontFamily: ConstantData.fontFamily),
                selectedTextStyle: TextStyle(
                    fontSize: getScreenPercentSize(context, 8),
                    color: primaryColor,
                    fontFamily: ConstantData.fontFamily),
                step: 1,
                haptics: true,
                onChanged: (value) => setState(() {
                  age = value;
                  userage = value.toString();
                  print(value);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget goalWeightWidget() {
   
    return StatefulBuilder(
      builder: (context, setState) => Container(
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              "What's your goal\nweight?",
            ),

            Container(
              margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (margin!)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: getTextField(new TextEditingController(
                                text: (isKg) ? kg.toString() : lbs.toString())),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          getTextWidget(
                              (isKg) ? "Kg" : "lb",
                              subTextColor,
                              TextAlign.end,
                              FontWeight.w600,
                              getScreenPercentSize(context, 2)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  getWeightTabWidget(setState)
                ],
              ),
            )

            
          ],
        ),
      ),
    );
  }

  Widget weightWidget() {
   
    return StatefulBuilder(
      builder: (context, setState) => Container(
        margin: EdgeInsets.all(margin!),
        child: Stack(
          children: [
            getHeaderText(
              "What's your current\nweight?",
            ),

            Container(
              margin: EdgeInsets.only(bottom: getScreenPercentSize(context, 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (margin!)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IntrinsicWidth(
                            child: getTextField(TextEditingController(
                                text: (isKg) ? kg.toString() : lbs.toString())),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          getTextWidget(
                              (isKg) ? "Kg" : "lb",
                              subTextColor,
                              TextAlign.end,
                              FontWeight.w600,
                              getScreenPercentSize(context, 2)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 0.5),
                  ),
                  getWeightTabWidget(setState)
                ],
              ),
            )

         
          ],
        ),
      ),
    );
  }

  getHeaderText(String s) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: getScreenPercentSize(context, 4)),
        child: getTextWidget(s, textColor, TextAlign.center, FontWeight.bold,
            getScreenPercentSize(context, 3)),
      ),
    );
  }

  Widget firstWidget(BuildContext context) {
        print("kajsdbfajsdbf");
    return Container(
      color: cellColor,
      margin: EdgeInsets.all(margin!),
      child: Stack(
        children: [
          getHeaderText("Tell us about yourself!"),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [getMaleCell(context), getFemaleCell(context)],
            ),
          )
        ],
      ),
    );
  }

  getMaleCell(BuildContext context) {


    double width = getWidthPercentSize(context, 35);
    double height = getWidthPercentSize(context, 40);
    // double height = getWidthPercentSize(context, 50);

    double radius = getPercentSize(height, 4);
    double subImage = getPercentSize(height, 60);
    return InkWell(
      onTap: () {
        setState(() {
      
          isMale = true;
          gender = 'Male';
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.all(getScreenPercentSize(context, 1.5)),
            decoration: BoxDecoration(
              color: isMale == true ? primaryColor : cellColor,
              border: Border.all(
                  color: (isMale)
                      ? Colors.transparent
                      : subTextColor.withOpacity(0.1),
                  width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                ConstantData.assetsPath + "male.png",
                height: subImage,
              ),
            ),
          ),
          getTextWidget(
              S.of(context).male,
              (isMale) ? primaryColor : subTextColor,
              TextAlign.left,
              FontWeight.bold,
              getScreenPercentSize(context, 2.5)),
        ],
      ),
    );
  }

  getFemaleCell(BuildContext context) {
    double width = getWidthPercentSize(context, 35);
    double height = getWidthPercentSize(context, 40);
    double radius = getPercentSize(height, 4);
    double subImage = getPercentSize(height, 60);

    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.all(getScreenPercentSize(context, 1.5)),
            decoration: BoxDecoration(
              color: isMale == false ? primaryColor : cellColor,
              border: Border.all(
                  color: (!isMale)
                      ? Colors.transparent
                      : subTextColor.withOpacity(0.1),
                  width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(radius),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                ConstantData.assetsPath + "female.png",
                height: subImage,
              ),
            ),
          ),
          getTextWidget(
              S.of(context).female,
              (!isMale) ? primaryColor : subTextColor,
              TextAlign.left,
              FontWeight.bold,
              getScreenPercentSize(context, 2.5)),
        ],
      ),
      onTap: () {
        setState(() {
          gender = 'Female';
          isMale = false;
        });
      },
    );
  }

  Future PostUserData() async {
    Map data = {
      "user_id": 2.toString(),
      'gender': context.read<GetUserDataProvider>().gender.toString(),
      'motive': context.read<GetUserDataProvider>().motive.toString(),
      'age': context.read<GetUserDataProvider>().age.toString(),
      'height': context.read<GetUserDataProvider>().height.toString(),
      'weight': context.read<GetUserDataProvider>().weight.toString(),
      'goal_weight': context.read<GetUserDataProvider>().weightarget.toString(),
      'diet': 'context.read<GetUserDataProvider>().dietplan'.toString(),
    };

    print(data);
    _setHeaders() => {
          'Accept': 'application/json',
          'Authorization': 'Bearer $currentusertoken'
        };

    http.Response response = await http.post(
        Uri.parse(
          'https://diet.appetitor.app/Celo/api/user/data',
        ),
        body: data,
        headers: _setHeaders());

    var responsedata = response.body;

    print(responsedata);
  }
}

// https://cdn.dribbble.com/users/1246317/screenshots/5393591/bmi-calculator_4x.png?compress=1&resize=400x300
