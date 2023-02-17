import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kriti/database.dart';
import 'package:kriti/popups/profilepopup.dart';
import 'package:kriti/popups/showPopUp.dart';
import 'package:upi_india/upi_india.dart';

// void main()=>{
//   runApp(MaterialApp(
//       home: HomePage()
//   ))
// };

class PaymentPage extends StatefulWidget {
  final String order_key;
  final String upi_id;
  final String payment_amount;
  final String shop_name;
  PaymentPage({Key? key,required this.upi_id, required this.payment_amount, required this.shop_name, required this.order_key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // var receiverupiid;
  // var receiverupiname;
  // var amount;
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  late Databases db;
  initialise() {
    db = Databases();
    db.initialise();
  }

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
    initialise();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: widget.upi_id,
      receiverName: widget.shop_name,
      transactionRefId: "knowshop${widget.order_key}",
      transactionNote: 'Paying to merchant',
      flexibleAmount: false,
      amount: int.parse(widget.payment_amount).toDouble(),
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.length == 0) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
                body,
                style: value,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Image.asset(
            'assets/images/bgImage1.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Image(
                height: 45.h,
                width: 45.h,
                image: const AssetImage("assets/images/appLogo.png"),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children:[
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text("Payment Gateway",textAlign: TextAlign.center,style: TextStyle(fontSize: 25)),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: displayUpiApps(),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _transaction,
                    builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              _upiErrorHandler(snapshot.error.runtimeType),
                              style: header,
                            ), // Print's text message on screen
                          );
                        }

                        // If we have data then definitely we will have UpiResponse.
                        // It cannot be null
                        UpiResponse _upiResponse = snapshot.data!;

                        // Data in UpiResponse can be null. Check before printing
                        String txnId = _upiResponse.transactionId ?? 'N/A';
                        String resCode = _upiResponse.responseCode ?? 'N/A';
                        String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                        String status = _upiResponse.status ?? 'N/A';
                        String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                        _checkTxnStatus(status);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              displayTransactionData('Transaction Id', txnId),
                              displayTransactionData('Response Code', resCode),
                              displayTransactionData('Reference Id', txnRef),
                              displayTransactionData('Status', status.toUpperCase()),
                              displayTransactionData('Approval No', approvalRef),
                              status.toUpperCase()=="FAILURE" ?Text("Payment not Completed"):Center(
                                child: Container(
                                    width:160.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        color:Color.fromRGBO(188, 157, 255, 1.0),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        db.PaymentSuccess(widget.order_key);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Order status",style:TextStyle(color:Color.fromRGBO(
                                          255, 255, 255, 1.0),),),
                                    )
                                ),
                              ),
                            ],
                          ),
                        );
                      } else
                        return Center(
                          child: Text(''),
                        );
                    },
                  ),
                )
              ],
            ),
          ),
        ]
    );
  }
}