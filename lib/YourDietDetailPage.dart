import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:flutter_diet_tips/util/ConstantWidget.dart';
import 'package:image/image.dart' as img;
import 'package:palette_generator/palette_generator.dart';

import 'Appetotor/ApiModel/ProductsModel.dart'; 
import 'model/FoodModel.dart';

class YourDietDetailPage extends StatefulWidget {
  final FoodModel foodModel;
  final Datum datanew;
  YourDietDetailPage(this.foodModel,this.datanew);

  @override
  _YourDietDetailPage createState() {
    return _YourDietDetailPage();
  }
}

class _YourDietDetailPage extends State<YourDietDetailPage> {
  FoodModel foodModel = new FoodModel();

  void onBackClick() {
    Navigator.of(context).pop();
  }

  List<String> ingredientsList = [
    "1 red apple",
    "1 beet",
    "1 stick celery",
    "green tea(optional)",
    "1 raspberries",
    "1 tsp ginger(optional)"
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      foodModel = widget.foodModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    double margin = getScreenPercentSize(context, 2);
    double horizontalMargin = getScreenPercentSize(context, 3.5);
    double height = getScreenPercentSize(context, 30);
    double viewHeight = getScreenPercentSize(context, 12);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: getPrimaryAppBarText(context, foodModel.title!),
            backgroundColor: primaryColor,
            centerTitle: false,
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: getPrimaryAppBarIcon(),
                  onPressed: onBackClick,
                );
              },
            ),
          ),
          body: SafeArea(
            child: Container(
              color: cellColor,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://diet.appetitor.app/Celo/${widget.datanew.image}'),
                            height: height,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: getPercentSize(height, 88)),
                        decoration: BoxDecoration(
                            color: cellColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    getScreenPercentSize(context, 4)),
                                topRight: Radius.circular(
                                    getScreenPercentSize(context, 4)))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: viewHeight / 2,
                            ),
                            Container(
                              margin: EdgeInsets.all(margin),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getTitle(widget.datanew.name!),
                                  //Container(child: Text(widget.datanew.detail.toString()),)
                                  getList(ingredientsList),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                        child: GestureDetector(
                                          onTap: (){
                                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderPlacment(datanew: widget.datanew,)));

                                          },
                                          child: GestureDetector(
                                            onTap: (){

                                                // when raised button is pressed
                                                // we display showModalBottomSheet
                                                showModalBottomSheet<void>(
                                                  backgroundColor: Colors.white,
                                                  // context and builder are
                                                  // required properties in this widget
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) {
                                                    // we set up a container inside which
                                                    // we create center column and display text

                                                    // Returning SizedBox instead of a Container
                                                    return SizedBox(
                                                      height: 250,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:  <
                                                            Widget>[
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding:EdgeInsets.only(top: 30,left: 25,right: 25),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        'Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                                    Text(
                                                                      'Islamabad',style: TextStyle(color: Colors.black54),),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:EdgeInsets.only(top: 15,left: 25,right: 25),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Current Wallet',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                                    Text(
                                                                      '100',style: TextStyle(color: Colors.black54),),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:EdgeInsets.only(top: 15,left: 25,right: 25),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
                                                                    Text(
                                                                      '100',style: TextStyle(color: Colors.black54),),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(left: 25,right: 25,top: 40),
                                                                child: Container(
                                                                  color:primaryColor,
                                                                  child: Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                                                                    child: Center(child: Text("Confirm Order")),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );

                                            },
                                            child: Container(
                                              color:primaryColor,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                                                child: Center(child: Text("Order")),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: margin,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: viewHeight,
                        margin: EdgeInsets.only(
                            top: getPercentSize(height, 70),
                            right: horizontalMargin,
                            left: horizontalMargin),
                        child: Card(
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  getPercentSize(viewHeight, 8)))),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getPercentSize(viewHeight, 5),
                                vertical: getPercentSize(viewHeight, 3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getCell(
                                    viewHeight, primaryColor, "Protein", widget.datanew.proteins.toString()),
                                Container(
                                  height: getPercentSize(viewHeight, 35),
                                  color: textColor,
                                  width: 1,
                                ),
                                getCell(viewHeight, Colors.red, "Fat", widget.datanew.fats.toString()),
                                Container(
                                  height: getPercentSize(viewHeight, 35),
                                  color: textColor,
                                  width: 1,
                                ),
                                getCell(
                                    viewHeight, Colors.orange, "Carbs",  widget.datanew.carbs.toString()),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          onBackClick();
          return false;
        });
  }

  img.Image? photo;

  getCell(double height, Color color, String s, String s1) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: color,
                size: getPercentSize(height, 10),
              ),

              SizedBox(
                width: getWidthPercentSize(context, 1),
              ),
              // Expanded(
              //   child:
              getTextWidget(s, subTextColor, TextAlign.start, FontWeight.w600,
                  getPercentSize(height, 14)),
              // )
            ],
          ),
          // Expanded(
          //   child:
          getTextWidget(s1, textColor, TextAlign.center, FontWeight.bold,
              getPercentSize(height, 16)),
          // )
        ],
      ),
    );
  }

  getList(List<String> list) {
    double margin = getScreenPercentSize(context, 2);
    double size = getScreenPercentSize(context, 1);
    // double size = getScreenPercentSize(context, 2.8);

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: (margin / 2)),
      // padding: EdgeInsets.symmetric(vertical: (margin / 2)),
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: primaryColor),
              ),
              Expanded(
                  child: getRobotoTextWidget(
                      list[index],
                      textColor,
                      TextAlign.start,
                      FontWeight.w600,
                      getScreenPercentSize(context, 2))),
            ],
          ),
        );
      },
    );
    // )
  }

  getTitle(String s) {
    double margin = getScreenPercentSize(context, 1.5);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: getScreenPercentSize(context, 0.5)),
            child: Text(
              s,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: getScreenPercentSize(context, 2.5),
                  color: textColor,
                  fontFamily: ConstantData.fontFamily,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: getScreenPercentSize(context, 0.5),
            width: getWidthPercentSize(context, 10),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(getScreenPercentSize(context, 0.5)))),
          )
        ],
      ),
    );
  }

  void setImageBytes(imageBytes) {
    print("setImageBytes");
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }

  // image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
  int abgrToArgb(int argbColor) {
    print("abgrToArgb");
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  // FUNCTION

  PaletteGenerator? paletteGenerator;
}