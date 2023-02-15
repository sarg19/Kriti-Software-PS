import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

void main()=>{
  runApp(MaterialApp(
      home: HomePage()
  ))
};

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var receiverupiid;
  var receiverupiname;
  var amount;
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
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: receiverupiid,
      receiverName: receiverupiname,
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      flexibleAmount: false,
      amount: int.parse(amount).toDouble(),
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
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
              title: Center(
                child: Container(
                  height:50,
                  width:50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Image(
                    image: AssetImage("assets/images/appLogo.png"),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 100.0,
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
                              status.toUpperCase()=="SUCCESS" ?Text("Payment not Completed"):Center(
                                child: Container(
                                    width:MediaQuery.of(context).size.width*0.7,
                                    height: MediaQuery.of(context).size.height*0.1,
                                    color:Color.fromRGBO(188, 157, 255, 1.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: TextButton(
                                      onPressed: ()=>print("Gone to the order status page"),
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