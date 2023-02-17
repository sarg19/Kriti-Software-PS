import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import '../components/bottomnavbarshop.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<ShopHome> {
  int _currentIndex = 0;
  bool _isopen = true;
  List _earnings = [2000,3000,4000,3200,0,1200,1000];
  List _days = ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"];

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.values,
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Subansiri Canteen',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    _isopen? 'Now Open' : 'Now Closed',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(114, 114, 114, 1.0),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      alignment: const Alignment(0,-1),
                      height: 98,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: SizedBox.expand(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            'Add Offer',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(114, 114, 114, 1.0),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      alignment: const Alignment(0,-1),
                      height: 43,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Center(
                        child: Text(
                          "Today's Earning is Rs.500",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(244, 233, 255, 1.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries>[
                        LineSeries<_ChartData,String>(
                          dataSource: _earnings.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final int value = entry.value;
                            final String day = _days[_days.length - index - 1];
                            return _ChartData(day,value);
                          }).toList().reversed.toList(),
                          xValueMapper: (_ChartData data, _) => data.day,
                          yValueMapper: (_ChartData data, _) => data.earnings,
                          color: Colors.black
                        )
                      ],
                    ),
                  ),
                ],
              );
  }
}

class _ChartData {
  _ChartData(this.day, this.earnings);

  final String day;
  final int earnings;
}