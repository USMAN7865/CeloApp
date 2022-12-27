import 'dart:async';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_diet_tips/TabHealthTip.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';

import '../Home/TabDiet.dart';
import '../../../TabDishes.dart';
import '../../../TabHome.dart';
import '../Setting/TabSetting.dart';
import '../../customWidget/fab_bottom_app_bar.dart';
import '../../customWidget/fab_with_icons.dart';
import '../../customWidget/layout.dart';
import '../../../generated/l10n.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with   TickerProviderStateMixin{
  static List<Widget> _widgetOptions = [];
  int _selectedIndex = 4;
  Color selectedItemsColors = Colors.white60;

  bool isVisible = true;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    ConstantData.setThemePosition();



    Timer(Duration(seconds: 1), () { 
    _selectedTab(4);

    }); 
  }
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),

    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCirc,
  );

  void _selectedTab(int index) {

    print("index---$index");
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex==4){
        selectedItemsColors = Colors.white70;
      }else{
        selectedItemsColors = Colors.white;
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    if(_widgetOptions.length <= 0){
     // setState(() {
       _widgetOptions = <Widget>[
         TabDishes((i) {
           _onBackPressed();
         }),
         TabHome((i) {
           if(i==0){
             _onBackPressed();
           }else{
               _selectedTab(1);
           }
         }),
         TabHealthTip((i) {
           if(i==0){
             _onBackPressed();
           }else{
               _selectedTab(2);
           }
         }),
         TabSetting((i) {


           print("settingIndex---$_selectedIndex");
           if(i==0){
             // _selectedTab(3);
           //
             _onBackPressed();
           //
           }
    else{

             ConstantData.setThemePosition();

               _selectedTab(3);

           }

         }),
         TabDiet((i) {

           _onBackPressed();


         }),
       ];
     // });
    //   _selectedTab(4);
    }

    print("_selectedIndex---$_selectedIndex");
    return new WillPopScope(
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            child: Scaffold(
              backgroundColor: backgroundColor,

              body: Center(
                // child: HomePage(),

                // child: Container(),
                child: (_widgetOptions.length > 0)
                    ? _widgetOptions.elementAt(_selectedIndex)
                    : Container(),
              ),
              bottomNavigationBar: Visibility(
                visible: isVisible,
                child: ColoredBox(
                  color: Colors.transparent,
                  child: FABBottomAppBar(
                    centerItemText: "",
                    backgroundColor: primaryColor,
                    selectedIndex:  _selectedIndex,
                    // color: ConstantDatas.bottomNavColor,
                    color: Colors.white60,


                    selectedColor: selectedItemsColors,
                    notchedShape: CircularNotchedRectangle(),

                    onTabSelected: (value){
                      _selectedTab(value);
                    },




                    items: [
                      FABBottomAppBarItem(
                          iconData: Icons.home,
                          text: 'Home'),

                      FABBottomAppBarItem(
                          iconData: Icons.category, text: "Recommendations"),
                      FABBottomAppBarItem(
                          iconData: Icons.medical_services,
                          text: "Subcriptions"),

                      FABBottomAppBarItem(
                          iconData: Icons.settings, text: S.of(context).setting),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: _buildFab(context),
              // ),
            ),
          ),
        ),
        onWillPop: () async {
          _onBackPressed();
          return false;
        });
  }

  _onBackPressed() {


    print("_selectedIndex----$_selectedIndex");
    if (_selectedIndex == 4) {

      if(Platform.isIOS){
        exit(0);
      }else{
        SystemNavigator.pop();
      }


      _controller.dispose();
    } else {

        _selectedTab(4);
    }
  }




  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return 
      Visibility(
        visible:isVisible,child: AnchoredOverlay(

        showOverlay: false,
        overlayBuilder: (context, offset) {
          return
            CenterAbout(
            // position: Offset(0, 0 ),
            position: Offset(offset.dx, offset.dy - icons.length * 35.0),
            child: FabWithIcons(
              icons: icons,
              onIconTapped: (value){
                _selectedTab(value);
              },
            ),
          );
        },
        child:
        FloatingActionButton(

          backgroundColor: primaryColor,foregroundColor: Colors.amber,

          onPressed: () {


            _selectedTab(4);
          },
          tooltip: 'Increment',
          child: Icon(
            Icons.home,
            color: (_selectedIndex == 4) ? Colors.white : Colors.white60,
          ),
          elevation: 2.0,
        ),
    ),
      );
  }
}
