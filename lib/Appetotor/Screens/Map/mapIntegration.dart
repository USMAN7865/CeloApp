import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/Appetotor/Provider/Getuserdata.dart';
import 'package:flutter_diet_tips/Appetotor/Screens/Home/TabDiet.dart';
import 'package:flutter_diet_tips/util/ConstantData.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MapIntegration extends StatefulWidget {
  const MapIntegration({super.key});

  @override
  State<MapIntegration> createState() => _MapIntegrationState();
}

class _MapIntegrationState extends State<MapIntegration> {
  Completer<GoogleMapController> _controller = Completer();

  String useradress = '';

  Uuid _uuid = Uuid();

  List<dynamic> _placeslist = [];

  String _sessiontoken = '12345';

  static final CameraPosition _kGoogleMaps =
      CameraPosition(target: LatLng(33.6330752, 73.0824704), zoom: 14);

  List<Marker> _marker = [];
  List<Marker> list = [
    Marker(
      infoWindow: InfoWindow(title: 'My Current Location'),
      markerId: MarkerId('1'),
      position: LatLng(33.6330752, 73.0824704),
    ),
  ];

  Future<Position> getcurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    loaddata();
    _searchplace.addListener(() {
      onchange();
    });
    _marker.addAll(list);
    getcurrentLocation();

    super.initState();
  }

  GeoCode geoCode = GeoCode();

  onchange() {
    if (_sessiontoken == null) {
      setState(() {
        _sessiontoken = _uuid.v4();
      });
    }

    getsuggestion(_searchplace.text);
  }

  getsuggestion(String input) async {
    String kPLACES_API_KEY = 'AIzaSyC9AlBpbZU5AAWNERdfdy5UkB0Sr0LM6AA';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessiontoken';

    var response = await http.get(Uri.parse(request));

    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placeslist = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load Api Data");
    }
  }

  loaddata() async {
    await getcurrentLocation().then((value) async {

      print(value.latitude);
      print(value.longitude);
      var adress = await geoCode.reverseGeocoding(latitude: value.latitude, longitude: value.longitude);
                 
        context.read<GetUserDataProvider>().setUserlocation(
            adress.streetNumber.toString() +
                adress.streetAddress.toString() +
                adress.city.toString() +
                adress.countryName.toString());
        useradress = adress.streetNumber.toString() +
            adress.streetAddress.toString() +
            adress.city.toString() +
            adress.countryName.toString();

            

            SharedPreferences localStorage = await SharedPreferences.getInstance();


            setState(() {
               localStorage.setString('currentlocation', useradress);
               localStorage.setString('Firstlocation', useradress);
            });
                 
           

        print(useradress);
    
      setState(() {
               
      });
      print(adress.streetAddress);

      _marker.add(
        Marker(
            markerId: MarkerId('2'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: InfoWindow(title: 'My Current Location')),
      );

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  TextEditingController _searchplace = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          title: Text(
            'Location',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            useradress == ""
                ? loaddata()
                : Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TabDiet((i) {});
                  }));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60.0,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(color: primaryColor, shape: BoxShape.rectangle),
              child: Text(
                useradress == "" ? "Get Current Location" : "Continue",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ), 
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [ 
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: _searchplace,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIconConstraints: BoxConstraints(minWidth: 20),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    labelText: 'Search Places',
                    hintText: 'Search Places',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              Container(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                      markers: Set<Marker>.of(_marker),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      initialCameraPosition: _kGoogleMaps),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
