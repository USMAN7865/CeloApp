import 'dart:convert';
import 'dart:io';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/userdataModel.dart';
import 'package:flutter_diet_tips/Appetotor/Config/config.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/Getuserdata.dart';
import 'package:flutter_diet_tips/Appetotor/FirstPage/FirstPage.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Dynamic/dynamicScreen.dart';
import 'package:flutter_diet_tips/Appetotor/customWidget/utils.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:flutter_diet_tips/util/ConstantWidget.dart';
import 'package:flutter_diet_tips/util/PrefData.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../ForgotPassword.dart';
import 'SignUpPage.dart';
import '../../../generated/l10n.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPage createState() {
    return _SignInPage();
  }
}

class _SignInPage extends State<SignInPage> {
  bool isRemember = false;
  // int themeMode = 0;
  TextEditingController textNameController = new TextEditingController();
  TextEditingController textPasswordController = new TextEditingController();

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    ConstantData.setThemePosition();
    setState(() {});
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? usertoken;

  Future<UserData> googleLoginResponse() async {
    String url =
        'https://diet.appetitor.app/Celo/api/login/callback?provider=google&access_provider_token=$usertoken';

    //click on google sign in. Get accessToken from google through googlesignin

    //Send accessToken to socialite in backend to request/create user data

    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      print('Google Signin ERROR! googleAccount: null!');
    }
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    //this is user access token from google that is retrieved with the plugin
    print("User Access Token: ${googleSignInAuthentication.accessToken}");
    String? accessToken = googleSignInAuthentication.accessToken;

    setState(() {
      print(accessToken);
      usertoken = accessToken;
    });

    //make http request to the laravel backend
    final response = await http.post(Uri.parse(url),
        body: json.encode({"token": accessToken}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200 || response.statusCode == 422) {
      return UserData.fromJson(
        json.decode(response.body), // {'message':'Google signin successful'}
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  var token;
  bool _isInAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: cellColor,
          appBar: AppBar(
            backgroundColor: cellColor,
            elevation: 0,
            title: Text(""),
            leading: GestureDetector(
              onTap: () {
                _requestPop();
              },
              child: Icon(
                Icons.keyboard_backspace,
                color: textColor,
              ),
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isInAsyncCall,
            color: Colors.transparent,
            progressIndicator: CircularProgressIndicator(color: primaryColor),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getScreenPercentSize(context, 2.5)),
              child: ListView(
                children: [
                  getTextWidget(S.of(context).signIn, textColor, TextAlign.left,
                      FontWeight.bold, getScreenPercentSize(context, 4.2)),
                  SizedBox(
                    height: getScreenPercentSize(context, 2.5),
                  ),
                  getTextFiled(
                      S.of(context).yourEmail, textNameController, false),
                  getTextFiled(
                      S.of(context).password, textPasswordController, true),
                  InkWell(
                    child: getTextWidget(
                      S.of(context).forgotPassword,
                      textColor,
                      TextAlign.end,
                      FontWeight.w600,
                      getScreenPercentSize(context, 1.8),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ));
                    },
                  ),
                  SizedBox(
                    height: getScreenPercentSize(context, 4),
                  ),
                  getTextButtonWidget(
                      context, S.of(context).signIn, Colors.orangeAccent,
                      () async {
                    setState(() {
                      _isInAsyncCall = true;
                    });

                    PrefData.setIsSignIn(true);
                    PrefData.setIsIntro(false);
                    await Signin().whenComplete(() {
                      _isInAsyncCall = false;
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getScreenPercentSize(context, .5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTextWidget(
                            S.of(context).dontHaveAnAccount,
                            textColor,
                            TextAlign.left,
                            FontWeight.w500,
                            getScreenPercentSize(context, 1.8)),
                        SizedBox(
                          width: getScreenPercentSize(context, 0.5),
                        ),
                        InkWell(
                          child: getTextWidget(
                              S.of(context).signUp,
                              primaryColor,
                              TextAlign.start,
                              FontWeight.bold,
                              getScreenPercentSize(context, 2)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              await googleLoginResponse();

                              /// For Google Login
                            },
                            child: Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/social/google.png')),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () {
                              //For Fb Login
                            },
                            child: Container(
                              height: 40,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/social/fb.png')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  getTextFiled(String s, TextEditingController controller, bool isPass) {
    Color color = Colors.grey;
    double editTextHeight = MediaQuery.of(context).size.height * 0.07;
    double defaultMargin = getScreenPercentSize(context, 2);

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: (defaultMargin)),
          padding: EdgeInsets.only(right: (defaultMargin / 1.5)),
          height: editTextHeight,
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() => color = hasFocus ? primaryColor : Colors.grey);
            },
            child: TextField(
              maxLines: 1,
              obscureText: isPass,
              controller: controller,
              style: TextStyle(
                  fontFamily: ConstantData.fontFamily,
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 1),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),

                labelStyle: TextStyle(
                    fontFamily: ConstantData.fontFamily, color: color),

                labelText: s,
                // hintText: 'Full Name',
              ),
            ),
          ),
        );
      },
    );
  }

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   token = jsonDecode(localStorage.getString('token')!)['token'];
  // }

  Future Signin() async {
    UserData? userdetails;
    //   await _getToken();
    Map data = {
      'email': textNameController.text,
      'password': textPasswordController.text,
    };

    http.Response response = await http.post(
      Uri.parse(Config.Base_Url + Config.Login),
      body: data,
    );

    var responsedata = json.decode(response.body);
    //  print(response.statusCode);
    bool isFirst = false;

    if (responsedata['success']) {
      Utils.flushSucessMessages("Succesfully Login", context);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', responsedata['data']['token'].toString());
      localStorage.setString('name', responsedata['data']['name'].toString());
      localStorage.setString('id', responsedata['data']['u_id'].toString());
      context
          .read<GetUserDataProvider>()
          .setUserId(responsedata['data']['u_id'].toString());

      try {
        String url =
            'https://diet.appetitor.app/Celo/api/user/cal/${responsedata['data']['u_id'].toString()}';
        var response = await Dio().get(url,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
        if (response.statusCode == 200) {
          userdetails = UserData.fromJson(response.data);
        }
      } on DioError catch (e) {
        print(e.response);
      }

      if (userdetails!.data![0].calories == null &&
          userdetails.data![0].fats == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FirstPage(),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    } else {
      Utils.flushBarErrorMessages("Login Failed", context);
      setState(() {
        _isInAsyncCall = false;
      });
    }

    print(responsedata);
  }
}
