// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/ManageDiet.dart';
import 'package:flutter_diet_tips/NotificationPage.dart';
import 'package:flutter_diet_tips/TabBMI.dart';
import 'package:flutter_diet_tips/Appetotor/customWidget/language.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:flutter_diet_tips/util/ConstantWidget.dart';
import 'package:flutter_diet_tips/util/PrefData.dart';
import 'package:flutter_diet_tips/util/SizeConfig.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../EditProfilePage.dart';
import '../../../FavouritePage.dart';
import '../../../ReminderPage.dart';
import '../Auth/SignUpPage.dart';
import '../../../generated/l10n.dart';

class TabSetting extends StatefulWidget {
  final ValueChanged<int> valueChanged;

  TabSetting(this.valueChanged);

  @override
  _TabSetting createState() {
    return _TabSetting();
  }
}

class _TabSetting extends State<TabSetting> {
  bool isSwitchOn = false;

  @override
  void initState() {
    ConstantData.setThemePosition();

    getThemeMode();
    super.initState();
  }

  double marginMain = 10;
  double radius = 10;
  double padding = 7;
  double paddingImage = 10;
  int boxWidth = 3;

  @override
  void didChangeDependencies() {
    build(context);
    super.didChangeDependencies();
  }

  

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double margin = getScreenPercentSize(context, 1);

    return WillPopScope(
      onWillPop: () async {
        onBackPress();
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: getPrimaryAppBarText(context, S.of(context).setting),
          backgroundColor: primaryColor,
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: getPrimaryAppBarIcon(),
                onPressed: () {
                  onBackPress();
                },
              );
            },
          ),  
        ),
        body: Container(
          child: ListView(
            padding:
                EdgeInsets.symmetric(vertical: margin, horizontal: margin / 2),
            children: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(marginMain),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: cellColor),
                  child: Padding(
                    padding: EdgeInsets.only(top: padding, bottom: padding),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(paddingImage),
                          child: Icon(
                            Icons.brightness_4_outlined,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * boxWidth,
                        ),
                        Expanded(
                          child: getSmallNormalText(
                              S.of(context).nightMode, textColor),
                          flex: 1,
                        ),
                        Switch(
                          value: isSwitchOn,
                          activeColor: primaryColor,
                          inactiveTrackColor: subTextColor,
                          onChanged: (value) {
                            setState(() {
                              isSwitchOn = value;

                              if (value) {
                                PrefData.setThemeMode(1);
                              } else {
                                PrefData.setThemeMode(0);
                              }

                              getThemeMode();

                              widget.valueChanged(1);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(marginMain),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: cellColor),
                  child: Padding(
                    padding: EdgeInsets.only(top: padding, bottom: padding),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(paddingImage),
                          child: Icon(
                            Icons.bar_chart,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * boxWidth,
                        ),
                        Expanded(
                          child: getSmallNormalText(
                              S.of(context).manageHealthCalculation, textColor),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabBMI(),
                      ));
                },
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageDiet(),
                      ));
                },
                data: S.of(context).manageDietPreference,
                icons: Icons.emoji_food_beverage,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderPage(),
                      ));
                },
                data: S.of(context).reminder,
                icons: Icons.timer,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ));
                },
                data: S.of(context).editProfile,
                icons: Icons.account_circle_sharp,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return FavouritePage();
                    },
                  ));
                },
                data: S.of(context).favourite,
                icons: Icons.favorite,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return NotificationPage();
                    },
                  ));
                },
                data: S.of(context).notification,
                icons: Icons.notifications,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  setState(() {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => const Languages());
                  });
                },
                data: 'Language',
                icons: Icons.language,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                 
                },
                data: S.of(context).privacyPolicy,
                icons: Icons.security,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {
                  share();
                },
                data: S.of(context).share,
                icons: Icons.share,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () {},
                data: S.of(context).rateUs,
                icons: Icons.star_rate,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () async {
                  final mailtoLink = Mailto(
                    to: ['to@example.com'],
                    subject: 'Feedback',
                    body: 'Health Tips',
                  );
                  await launchUrl(Uri.parse('$mailtoLink'));
                },
                data: S.of(context).feedback,
                icons: Icons.feedback,
              ),
              settingcard(
                marginMain: marginMain,
                radius: radius,
                padding: padding,
                paddingImage: paddingImage,
                boxWidth: boxWidth,
                ontap: () async {
                  PrefData.setIsSignIn(false);
                  PrefData.setIsFirstTime(true);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                  ;
                },
                data: S.of(context).logOut,
                icons: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  getThemeMode() async {
    int i = await PrefData.getThemeMode();

    if (i == 1) {
      isSwitchOn = true;
    } else {
      isSwitchOn = false;
    }
    ConstantData.setThemePosition();

    setState(() {});
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: S.of(context).appName,
        text: S.of(context).appName,
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Share App');
  }

  void onBackPress() {
    widget.valueChanged(0);
  }
}

class settingcard extends StatelessWidget {
  settingcard({
    Key? key,
    required this.marginMain,
    required this.radius,
    required this.padding,
    required this.paddingImage,
    required this.boxWidth,
    required this.icons,
    required this.data,
    required this.ontap,
  }) : super(key: key);

  final double marginMain;
  final double radius;
  final double padding;
  final double paddingImage;
  final int boxWidth;
  IconData icons;
  String data;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(marginMain),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: cellColor),
        child: Padding(
          padding: EdgeInsets.only(top: padding, bottom: padding),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(paddingImage),
                child: Icon(
                  icons,
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal! * boxWidth,
              ),
              Expanded(
                child: getSmallNormalText(data, textColor),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      onTap: ontap,
    );
  }
}
