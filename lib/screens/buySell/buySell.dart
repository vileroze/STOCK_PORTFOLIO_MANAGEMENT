import 'package:flutter/material.dart';
import 'package:portfolio_management/screens/buySell/commonLayout.dart';

class BuySell extends StatefulWidget {
  const BuySell({Key? key}) : super(key: key);

  @override
  State<BuySell> createState() => _BuySellState();
}

class _BuySellState extends State<BuySell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              color: Color.fromARGB(255, 4, 151, 110),
              child: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: TabBar(
                  unselectedLabelColor: Colors.grey[300],
                  // labelColor: Color.fromARGB(255, 16, 228, 169),
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: Color.fromARGB(255, 16, 228, 169),
                  indicatorWeight: 5,
                  // indicator: BoxDecoration(color: Colors.grey[50]),
                  tabs: [
                    Tab(
                      child: Text('BUY'),
                    ),
                    Tab(
                      child: Text('SELL'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // color: Colors.grey[50],
              height: size.height / 1.5,
              child: TabBarView(
                children: [
                  CommonLayout('BuyPage'),
                  CommonLayout('SellPage'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
