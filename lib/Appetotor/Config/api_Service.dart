import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/ProductsModel.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/bannerModel.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/packageModel.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/userdata.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/userdataModel.dart';
import 'package:flutter_diet_tips/Appetotor/Config/config.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/Getuserdata.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  var token;
  var search = [];

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!)['token'];
  }

  authData(data, apiUrl) async {
    var fullUrl = Config.Base_Url + Config.Login;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = Config.Base_Url + Config.Login;
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  //User Details
  Future<List<UserData>> getUserData(BuildContext context) async {
    List<UserData> products = [];
    UserData? userdetails;
    try {
      String url =
          'https://diet.appetitor.app/Celo/api/user/cal/${context.read<GetUserDataProvider>().userid}';
      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.data);
        userdetails = UserData.fromJson(response.data);
        UserDatamodel.calories = userdetails.data![0].calories.toString();
        UserDatamodel.fats = userdetails.data![0].fats.toString();
        UserDatamodel.protiens = userdetails.data![0].proteins.toString();
        UserDatamodel.carbs = userdetails.data![0].calories.toString();

        // products = response.data.map((e) {
        //   return UserData.fromJson(e);
        // }).toList();
        //List

      }
    } on DioError catch (e) {
      print(e.response);
    }
    return products;
  }

//PRODUCTS
  //Products
  Future<List<ProductsModel>> getProducts(
      {String? calories, String? type, String? day}) async {
    List<ProductsModel> products = [];

    print("Selected type is $type");
    print("Selected Day is $day");

    try {
      String url =
          'https://diet.appetitor.app/Celo/api/food/type/55/$type/$day';
      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (response.statusCode == 200) {
        ProductsModel.fromJson(response.data);
        products.add(ProductsModel.fromJson(response.data));
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return products;
  }

//PRODUCTS
  //Products
  Future<List<PackageModel>> getPackages() async {
    List<PackageModel> products = [];

    try {
      String url = 'https://diet.appetitor.app/Celo/api/package';
      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (response.statusCode == 200) {
        PackageModel.fromJson(response.data);
        products.add(PackageModel.fromJson(response.data));
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return products;
  }

  //Banner
  Future<List<BannerModel>> getBanners() async {
    List<BannerModel> banners = [];
    BannerModel fact;

    try {
      String url = 'https://diet.appetitor.app/Celo/api/banner';
      var response = await http
          .get(Uri.parse(url), headers: {"Content-Type": "application/json"}
              // options: Options(headers: {
              //   HttpHeaders.contentTypeHeader: "application/json",
              // })

              );
      if (response.statusCode == 200) {

    //    print(response.body);
        final jsonresponse = json.decode(response.body);
        List<dynamic> list = await json.decode(response.body);

        list.forEach((e) {

          print(e);
          banners.add(BannerModel.fromJson(e));
        });

        //  BannerModel.fromJson(jsonresponse);
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return banners;
  }
}
