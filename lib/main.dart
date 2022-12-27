import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Dynamic/dynamicScreen.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/Getuserdata.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/languageprovider.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Map/mapIntegration.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Packages/package.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Splash/videoSplash.dart';
import 'package:flutter_diet_tips/Appetotor/customWidget/videowidget.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:flutter_diet_tips/util/ConstantWidget.dart';
import 'package:flutter_diet_tips/util/PrefData.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'Appetotor/Screens/Payments/paymentintegration.dart';
import 'Appetotor/FirstPage/FirstPage.dart';
import 'IntroPage.dart';
import 'Appetotor/Screens/Auth/SignUpPage.dart';
import 'generated/l10n.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
Stripe.publishableKey="pk_test_51M2TlrIyZcrUZatMJdZyAsGdcbeo7lmI7Htr5FThBQ10uJ6FK9KeJoDuDf99URfKADMDOQ4kWQIdp5CsKhDeJ2ru00gcVYwrQZ";
  runApp(
    MyApp(),

  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConstantData.setThemePosition();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChangeLanguageProvider>(
          create: (context) => ChangeLanguageProvider(),
        ),
        ChangeNotifierProvider<GetUserDataProvider>(
          create: (context) => GetUserDataProvider(),
        ),
      ],
      child: Builder(
        builder:  (context) => MaterialApp(
 
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate
          ],
          locale: Provider.of<ChangeLanguageProvider>(context, listen: true).currentLocale,
          supportedLocales: [
             Locale('en', 'US'),
             Locale('ar', 'SA'),
           
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: primaryColor,
            primaryColorDark: primaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          home: 
          // Packages()
           MyHomePage(title: '',)
          //  MyHomePage(
          //   title: "title",
          // ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isSignIn = false;
  bool _isIntro = false;
  bool _isFirstTime = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:primaryColor, // status bar color
    ));


    Timer(Duration(seconds: 4), (){
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MenuFrame()));
    });

    // MenuFrame();
    // signInValue();
  }

  // void signInValue() async {
  //   _isSignIn = await PrefData.getIsSignIn();
  //   _isIntro = await PrefData.getIsIntro();
  //   _isFirstTime = await PrefData.getIsFirstTime();
  //   Timer(Duration(seconds: 3), () {
      
  //     print("isIntro=----$_isIntro---$_isFirstTime");
  //     if (_isIntro) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => IntroPage()));
  //     } else if (!_isSignIn) {
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => SignUpPage(),
  //           ));
  //     } else {
  //       if (_isFirstTime) {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => FirstPage(),
  //             ));
  //       } else
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => HomePage(),
  //             ));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00adbb), 
      body: Stack(
       children: [
      //  VideoWidget(),
         Center(
         child: Image.asset(ConstantData.assetsPath+"splashLogo.png",height: getScreenPercentSize(context,22),),
      
        ),
       ],
      ),
    );
  }
}
