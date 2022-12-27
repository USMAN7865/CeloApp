import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_diet_tips/Appetotor/ApiModel/packageModel.dart';
import 'package:flutter_diet_tips/Appetotor/Config/api_Service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  CallApi apiService = CallApi();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: getPackagelist(),
      )),
    );
  }

  //Products List
  Widget getPackagelist() {
    return FutureBuilder(
        future: apiService.getPackages(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PackageModel>> model) {
          if (model.hasData) {
            return buildproductlist(model.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget buildproductlist(List<PackageModel> products) {
    return ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          PackageModel data = products[index];
          return Row(
              children: data.data!.map((e) {
            return packages(
              price: e.price.toString(),
              title: e.name.toString(),
              duration: e.detail.toString(),
              details: e.detail.toString(),
            ); 
          }).toList());
        });
  }
}

class packages extends StatefulWidget {
  String title;
  String price;
  String duration;
  String details;
  packages({Key? key,required this.price,required this.title,required this.details,required this.duration}) : super(key: key);

  @override
  State<packages> createState() => _packagesState();
}

class _packagesState extends State<packages> {
  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width-50,
          height: MediaQuery.of(context).size.height * 0.8,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                widget.title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                widget.price,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700]),
              ),
              Text(
                widget.duration,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.green[700]),
              ),
              Spacer(),
              Text(
                widget.details,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  makePayment(widget.price,"s");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'Go $widget.title',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  Future<void> makePayment(String ammount,String qID) async {
    try {
      paymentIntent = await createPaymentIntent(ammount, 'PKR');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan'))
          .then((value) {

      });

      ///now finally display payment sheeet

      displayPaymentSheet(qID);
      //deleteData(qID);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }


  displayPaymentSheet(String qID) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text("Cancelled"),
                    ],
                  ),
                ],
              ),
            ));
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
          'Bearer sk_test_51M2TlrIyZcrUZatMeCCJJ2zu71hW6xXnmIxph9jkUMXsbaS95fU17u5yTQsbspJZFf9EFjxBR93ZxMFOyStaY2EL00THiX7PAQ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}

// class SubPackages extends StatelessWidget {
//   String title;
//   String price;
//   String duration;
//   String details;
//
//   SubPackages({
//     required this.title,
//     required this.price,
//     required this.duration,
//     required this.details,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width-50,
//           height: MediaQuery.of(context).size.height * 0.8,
//           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           decoration: BoxDecoration(
//             color: Colors.green[50],
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 price,
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green[700]),
//               ),
//               Text(
//                 duration,
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.green[700]),
//               ),
//               Spacer(),
//               Text(
//                 details,
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey[400]),
//                 textAlign: TextAlign.center,
//               ),
//               Spacer(),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 50,
//                 margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.green[700],
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Go $title',
//                     style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
// }
