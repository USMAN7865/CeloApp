import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocode/geocode.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  GeoCode geoCode = GeoCode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(children: [
         
          Center(child: ElevatedButton(onPressed: () async{ 

            var adress= await geoCode.reverseGeocoding(latitude: 33.6330752,longitude:  73.0824704);
            print(adress.streetAddress);
          },
          child: Text(''),
          ),
          )
        ],),
      )
    );
  }
}