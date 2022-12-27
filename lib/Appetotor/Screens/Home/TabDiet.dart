import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/ProductsModel.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/bannerModel.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/userdata.dart';
import 'package:flutter_diet_tips/Appetotor/Config/api_Service.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/Getuserdata.dart';
import 'package:flutter_diet_tips/model/CategoryModel.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:flutter_diet_tips/util/ConstantWidget.dart';
import 'package:flutter_diet_tips/util/DataFile.dart';
import 'package:flutter_diet_tips/util/SizeConfig.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../YourDietDetailPage.dart';
import '../../../generated/l10n.dart';
import '../../../model/FoodModel.dart';

class TabDiet extends StatefulWidget {
  final ValueChanged<int> valueChanged;

  TabDiet(this.valueChanged);

  @override
  _TabDiet createState() {
    return _TabDiet();
  }
}

class _TabDiet extends State<TabDiet> {
  int categoryPosition = 0;
  DateTime dateTime = DateTime.now();

  List<String> list = ["Breakfast", "Snack", "Lunch", "Dinner"];
  final controller = CarouselController();
  int wallet=200;
  List<FoodModel> sliderList = DataFile.getFoodList();
  List<CategoryModel> categoryList = DataFile.getCategoryList();
  SharedPreferences? localStorage;
  // AutoScrollController? _controller;
  initialzelocalstorage() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initialzelocalstorage();
    super.initState();
    // _controller = AutoScrollController(
    //     viewportBoundaryGetter: () =>
    //         Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    //     axis: Axis.horizontal);
  }

  CallApi apiService = CallApi();

  @override
  void didChangeDependencies() {
    build(context);
    super.didChangeDependencies();
  }

  String selectedday = 1.toString();
  String selectedtype = 'breakfast'.toString();
  @override
  Widget build(BuildContext context) {
    CallApi().getUserData(context);
    CallApi().getBanners();
    SizeConfig().init(context);
    double height = getScreenPercentSize(context, 5);
    double appBarHeight = getScreenPercentSize(context, 13);
    double listHeight = getScreenPercentSize(context, 42);
    double radius1 = getPercentSize(appBarHeight, 25);
    double radius = getPercentSize(listHeight, 2);

    return WillPopScope(
      onWillPop: () async {
        widget.valueChanged(0);
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: getScreenPercentSize(context, 2)),
                    height: appBarHeight,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radius1 * 1.5),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: getWidthPercentSize(context, 4),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () { 
                                  },
                                  child: getTextWidget(
                                      "Hey!",
                                      Colors.white,
                                      TextAlign.start,
                                      FontWeight.w600,
                                      getPercentSize(appBarHeight, 22)),
                                ),
                                Container(
                                  height: getPercentSize(appBarHeight, 3),
                                ),
                                getTextWidget(
                                    "Your Meal Plan",
                                    Colors.white70,
                                    TextAlign.start,
                                    FontWeight.w300,
                                    getPercentSize(appBarHeight, 12)),
                              ],
                            )),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                               child: Text("Wallet: \$"+wallet.toString(),style: TextStyle(fontSize: 18),),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff00adbb),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 5,
                          ),
                          getTextWidget(
                              "Your Details",
                              Colors.black,
                              TextAlign.start,
                              FontWeight.w600,
                              getPercentSize(appBarHeight, 22)),
                          Container(
                            height: 15,
                          ),
                          getTextWidget(
                              localStorage
                                      ?.getString('currentlocation')
                                      .toString() ??
                                  '',
                              Colors.white,
                              TextAlign.start,
                              FontWeight.w600,
                              getPercentSize(appBarHeight, 10)),
                          Container(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Calories :- ${UserDatamodel.calories.toString()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 9,
                              ),
                              Text(
                                "Fats  : -     ${UserDatamodel.fats.toString()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            height: 9,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Carbs : -    ${UserDatamodel.carbs.toString()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: 9,
                              ),
                              Text(
                                "Protein : -  ${UserDatamodel.protiens.toString()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 230, child: getBannerImage()),
                  Container(
                    height: 600,
                    child: Flexible(
                      fit: FlexFit.loose,
                      child: ListView(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chevron_left,
                                  size: getScreenPercentSize(context, 3),
                                  color: primaryColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: getTextWidget(
                                      "Dec 24 - 30 Dec",
                                      primaryColor,
                                      TextAlign.start,
                                      FontWeight.bold,
                                      getScreenPercentSize(context, 2)),
                                ),
                                Icon(
                                  Icons.navigate_next,
                                  size: getScreenPercentSize(context, 3),
                                  color: primaryColor,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            padding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            color: cellColor,
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),
                              daysCount: 5,
                              width: 70,
                              selectionColor: primaryColor,
                              selectedTextColor: Colors.white,
                              // dayTextStyle: TextStyle(color: textColor),
                              dayTextStyle: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: getScreenPercentSize(context, 1.5)),

                              monthTextStyle: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: getScreenPercentSize(context, 1.5)),
                              dateTextStyle: TextStyle(
                                  color: textColor, fontWeight: FontWeight.w800),
                              onDateChange: (date) {
                                setState(() {
                                  dateTime = date;
                                });

                                String formatteddate =
                                    DateFormat('yyyy-MM-dd').format(date);
                                if (formatteddate ==
                                    DateFormat('yyyy-MM-dd').format(DateTime(
                                        date.year, date.month, date.day))) {
                                  setState(() {
                                    selectedday = '1';
                                    getproductslist(selectedtype, selectedday);
                                  });
                                }

                                if (formatteddate ==
                                    DateFormat('yyyy-MM-dd').format(DateTime(
                                        date.year, date.month, date.day + 1))) {
                                  setState(() {
                                    selectedday = '2';
                                    getproductslist(selectedtype, selectedday);
                                  });
                                } else if (formatteddate ==
                                    DateFormat('yyyy-MM-dd').format(DateTime(
                                        dateTime.year,
                                        dateTime.month,
                                        dateTime.day + 2))) {
                                  setState(() {
                                    selectedday = '3';
                                    getproductslist(selectedtype, selectedday);
                                  });
                                } else if (formatteddate ==
                                    DateFormat('yyyy-MM-dd').format(DateTime(
                                        dateTime.year,
                                        dateTime.month,
                                        dateTime.day + 3))) {
                                  setState(() {
                                    selectedday = '4';
                                    print(selectedday);
                                    getproductslist(selectedtype, selectedday);
                                  });
                                } else if (formatteddate ==
                                    DateFormat('yyyy-MM-dd').format(DateTime(
                                        dateTime.year,
                                        dateTime.month,
                                        dateTime.day + 5))) {
                                  setState(() {
                                    selectedday = '5';
                                    getproductslist(selectedtype, selectedday);
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            height: height,
                            margin: EdgeInsets.symmetric(
                                vertical: getScreenPercentSize(context, 2)),
                            child: ListView.builder(
                              itemCount: 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                bool isSelected = categoryPosition == index;
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(4))),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedtype = 'breakfast';
                                                  getproductslist(
                                                      selectedtype, selectedday);
                                                  isSelected = true;
                                                });
                                              },
                                              child: getTextWidget(
                                                  'Break Fast',
                                                  (isSelected)
                                                      ? textColor
                                                      : textColor,
                                                  TextAlign.start,
                                                  (isSelected)
                                                      ? FontWeight.w800
                                                      : FontWeight.w500,
                                                  getPercentSize(height, 40)),
                                            ),
                                            Container(
                                              width: 13,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedtype = 'Snack';
                                                  getproductslist(
                                                      selectedtype, selectedday);
                                                  isSelected = true;
                                                });
                                              },
                                              child: getTextWidget(
                                                  'Snack',
                                                  (isSelected)
                                                      ? textColor
                                                      : textColor,
                                                  TextAlign.start,
                                                  (isSelected)
                                                      ? FontWeight.w800
                                                      : FontWeight.w500,
                                                  getPercentSize(height, 40)),
                                            ),
                                            Container(
                                              width: 13,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedtype = 'lunch';
                                                  getproductslist(
                                                      selectedtype, selectedday);
                                                });
                                              },
                                              child: getTextWidget(
                                                  'Lunch',
                                                  (isSelected)
                                                      ? textColor
                                                      : textColor,
                                                  TextAlign.start,
                                                  (isSelected)
                                                      ? FontWeight.w800
                                                      : FontWeight.w500,
                                                  getPercentSize(height, 40)),
                                            ),
                                            Container(
                                              width: 13,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedtype = 'dinner';
                                                  getproductslist(
                                                      selectedtype, selectedday);
                                                  isSelected = true;
                                                });
                                              },
                                              child: getTextWidget(
                                                  'Dinner',
                                                  (isSelected)
                                                      ? textColor
                                                      : textColor,
                                                  TextAlign.start,
                                                  (isSelected)
                                                      ? FontWeight.w800
                                                      : FontWeight.w500,
                                                  getPercentSize(height, 40)),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 13,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      categoryPosition = index;
                                    });

                                    // setState(() {
                                    //   print("Current index is $index");
                                    //   if(index == 0){
                                    //     setState(() {
                                    //       selectedday =1.toString();
                                    //       CallApi().getProducts();
                                    //          print(selectedday);
                                    //     });

                                    //   }else if (index ==1){
                                    //     setState(() {
                                    //       selectedday=2.toString();
                                    //       CallApi().getProducts();
                                    //          print(selectedday);
                                    //     });

                                    //   }
                                    //   else if(index == 2){
                                    //     setState(() {
                                    //          selectedday = 3.toString();
                                    //          CallApi().getProducts();
                                    //     });

                                    //   }else if(index == 3){
                                    //     setState(() {
                                    //         selectedday = 4.toString();
                                    //         CallApi().getProducts();
                                    //         print(selectedday);
                                    //     });

                                    //   }

                                    // });
                                  },
                                );
                              },
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 490,
                              margin: EdgeInsets.only(
                                  bottom: getScreenPercentSize(context, 2)),
                              child: getproductslist(selectedtype, selectedday),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getList(List<String> list, double height) {
    double margin = getPercentSize(height, 2);
    double size = getPercentSize(height, 3);

    return Stack(
      children: [
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: (margin / 2)),
          itemCount: list.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: margin / 2),
              child: Row(
                children: [
                  Container(
                    height: size,
                    width: size,
                    margin: EdgeInsets.only(right: margin),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                      child: getRobotoTextWidget(
                          list[index],
                          textColor,
                          TextAlign.start,
                          FontWeight.w600,
                          getPercentSize(height, 8.5))),
                ],
              ),
            );
          },
        ),
      ],
    );
    // )
  }

  getCell(double height, Color color, String s, String s1) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              color: color,
              size: getPercentSize(height, 5),
            ),

            Container(
              width: getWidthPercentSize(context, 1),
            ),

            getTextWidget(s, subTextColor, TextAlign.start, FontWeight.w600,
                getPercentSize(height, 8)),
            // )
          ],
        ),
        getTextWidget(s1, textColor, TextAlign.center, FontWeight.bold,
            getPercentSize(height, 10)),
      ],
    );
  }

  //Products List
  Widget getBannerImage() {
    return FutureBuilder(
        future: apiService.getBanners(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BannerModel>> model) {
          if (model.hasData) {
            return buildbannerlist(model.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildbannerlist(List<BannerModel> products) {
    print(products.length);
    return CarouselSlider(
        options: CarouselOptions(
          height: 180.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        items: products.map((e) {
          return Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage("https://diet.appetitor.app/Celo/${e.url}"),
                fit: BoxFit.cover,
              ),
            ),
            // child: Text(e.id.toString()),
          );
        }).toList());
  }

  //Products List
  Widget getproductslist(
    String type,
    String day,
  ) {
    return FutureBuilder(
        future: apiService.getProducts(
            type: type, day: day, calories: 2000.toString()),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductsModel>> model) {
          if (model.hasData) {
            return buildproductlist(model.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildproductlist(List<ProductsModel> products) {
    SizeConfig().init(context);

    double listHeight = getScreenPercentSize(context, 42);

    double radius = getPercentSize(listHeight, 2);

    print(products.length);

    return Container(
        height: 110,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              var data = products[index];
              double imgHeight = getPercentSize(listHeight, 60);
              double remainHeight = listHeight - imgHeight;
              return Row(
                children: data.data!.map((e) {
                  return InkWell(
                    child: VisibilityDetector(
                      key: Key(index.toString()),
                      onVisibilityChanged: (VisibilityInfo info) {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        color: cellColor,
                        child: Container(
                          height: 380,
                          width: getWidthPercentSize(context, 75),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(radius),
                                    topLeft: Radius.circular(radius)),
                                child: Stack(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          'https://diet.appetitor.app/Celo/${e.image}'),
                                      height: imgHeight,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getPercentSize(
                                                  remainHeight, 5),
                                              vertical: getPercentSize(
                                                  remainHeight, 6)),
                                          child: getTextWidget(
                                              e.type.toString(),
                                              Colors.white,
                                              TextAlign.start,
                                              FontWeight.w800,
                                              getPercentSize(remainHeight, 15)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: getPercentSize(remainHeight, 3),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getPercentSize(
                                                  remainHeight, 5),
                                              vertical: getPercentSize(
                                                  remainHeight, 6)),
                                          child: getTextWidget(
                                              e.name.toString(),
                                              Colors.black,
                                              TextAlign.start,
                                              FontWeight.w800,
                                              getPercentSize(remainHeight, 8)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: getPercentSize(remainHeight, 5),
                                    ),
                                    Container(
                                      height: 92,
                                      child: Container(
                                        color: primaryColor.withOpacity(0.1),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                getPercentSize(remainHeight, 5),
                                            vertical: getPercentSize(
                                                remainHeight, 3)),
                                        child: Row(
                                          children: [
                                            getCell(remainHeight, primaryColor,
                                                "Protein", "${e.proteins}"),
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Container(),
                                              flex: 1,
                                            ),
                                            getCell(remainHeight, Colors.red,
                                                "Fat", "${e.fats}"),
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Container(),
                                              flex: 1,
                                            ),
                                            getCell(remainHeight, Colors.orange,
                                                "Carbs", "${e.carbs}"),
                                            Flexible(
                                              fit: FlexFit.loose,
                                              child: Container(),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                YourDietDetailPage(sliderList[index],e),
                          ));
                    },
                  );
                }).toList(),
              );
            }));
  }
}
