import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import 'edit_text.dart';


void main() {
  runApp(TestPayment());
}

class TestPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String mid = "txSGuH70208097700957", orderId = "213", amount = "1", txnToken = "+OU7i5egIhFOjaMZCQm7Y\/yoM6dbmPmdaWmxT9G5OPQNaJI2BnLXWyGhvJkSG86AUzSvsoh\/3Y5NDawiFyGQWPsp\/dehNO4qw8S8U5rVV8M=";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool testing = true;//testing for true

  @override
  void initState() {

     // orderId = DateTime.now().millisecondsSinceEpoch.toString();
     callbackUrl = (testing
         ? 'https://securegw-stage.paytm.in'
         : 'https://securegw.paytm.in') +
         '/theia/paytmCallback?ORDER_ID=' +
         orderId;
    // print("orderId"+orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              EditText('Merchant ID', mid, onChange: (val) => mid = val),
              EditText('Order ID', orderId, onChange: (val) => orderId = val),
              EditText('Amount', amount, onChange: (val) => amount = val),
              EditText('Transaction Token', txnToken,
                  onChange: (val) => txnToken = val),
              Row(
                children: <Widget>[
                  Checkbox(
                      activeColor: Theme.of(context).buttonColor,
                      value: isStaging,
                      onChanged: (bool val) {
                        setState(() {
                          isStaging = val;
                        });
                      }),
                  Text("Staging")
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      activeColor: Theme.of(context).buttonColor,
                      value: restrictAppInvoke,
                      onChanged: (bool val) {
                        setState(() {
                          restrictAppInvoke = val;
                        });
                      }),
                  Text("Restrict AppInvoke")
                ],
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: RaisedButton(
                  onPressed: isApiCallInprogress
                      ? null
                      : () {
                    _startTransaction();
                  },
                  child: Text('Start Transcation'),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Text("Message : "),
              ),
              Container(
                child: Text(result),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(
          mid, orderId, amount, txnToken, null, isStaging, restrictAppInvoke);
      response.then((value) {
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message + " \n  " + onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.message;
    }
  }
}