import 'package:flutter/material.dart';
import 'package:portfolio_management/screens/detailedView/available_stocks.dart';
import 'package:recase/recase.dart';
import 'package:firebase_database/firebase_database.dart';

class IndividualStockDetail extends StatefulWidget {
  final String stock_name;
  IndividualStockDetail(this.stock_name);

  @override
  State<IndividualStockDetail> createState() => _IndividualStockDetailState();
}

class _IndividualStockDetailState extends State<IndividualStockDetail> {
  final _database = FirebaseDatabase.instance.ref();
  int totalUnits = 0;
  int capitalInvested = 0;
  int totalSold = 0;
  int currentValuation = 0;
  int totalProfit = 0;

  @override
  void initState() {
    super.initState();
    _getNumberOfStocks();
    _getCapitalInvested();
    _getValuationOfStocksSold();
    _getCurrentValuationOfStocks();
    _getAllTimeProfit();
  }

  void _getNumberOfStocks() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));
      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

        if (widget.stock_name == indTransaction['stock_name']) {
          if (indTransaction['type'] == 'Buy') {
            // print('Buyyyyyyyyyyyyy -   ' + indTransaction['quantity'].toString());
            setState(() {
              totalUnits += indTransaction['quantity'] as int;
            });
          } else {
            // print('Soldddddddddd -   ' + indTransaction['quantity'].toString());
            setState(() {
              totalUnits -= indTransaction['quantity'] as int;
            });
          }
        }
      });
    });
  }

  void _getCapitalInvested() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));
      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

        if (widget.stock_name == indTransaction['stock_name']) {
          if (indTransaction['type'] == 'Buy') {
            // print('Buyyyyyyyyyyyyy -   ' + indTransaction['amount'].toString());
            setState(() {
              capitalInvested += indTransaction['amount'] as int;
            });
          }
        }
      });
    });
  }

  void _getValuationOfStocksSold() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));
      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

        if (widget.stock_name == indTransaction['stock_name']) {
          if (indTransaction['type'] == 'Sell') {
            // print('Buyyyyyyyyyyyyy -   ' + indTransaction['amount'].toString());
            setState(() {
              totalSold += indTransaction['amount'] as int;
            });
          }
        }
      });
    });
  }

  void _getCurrentValuationOfStocks() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));
      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

        if (widget.stock_name == indTransaction['stock_name']) {
          if (indTransaction['type'] == 'Buy') {
            // print('Buyyyyyyyyyyyyy -   ' + indTransaction['quantity'].toString());
            setState(() {
              currentValuation += indTransaction['amount'] as int;
            });
          } else {
            // print('Soldddddddddd -   ' + indTransaction['quantity'].toString());
            setState(() {
              currentValuation -= indTransaction['amount'] as int;
            });
          }
        }
      });
    });
  }

  void _getAllTimeProfit() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 4, 151, 110), //change your color here
        ),
        title: Text(
          widget.stock_name.titleCase,
          style: TextStyle(
            fontSize: size.width / 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            letterSpacing: 2.0,
            color: Color.fromARGB(255, 4, 151, 110),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: size.width / 10,
            backgroundColor: Color.fromARGB(255, 4, 151, 110),
            child: Text(
              getInitials(widget.stock_name.titleCase),
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashBoardContainer(
                  'totalUnits',
                  Icons.area_chart_rounded,
                  Color.fromARGB(255, 4, 151, 110),
                  totalUnits.toString(),
                  'unit of stock currently in profile',
                  Color.fromARGB(255, 236, 229, 229),
                ),
                DashBoardContainer(
                  'totalInvestment',
                  Icons.monetization_on_rounded,
                  Color.fromARGB(255, 4, 151, 110),
                  capitalInvested.toString(),
                  'Total capital invested so far',
                  Color.fromARGB(255, 236, 229, 229),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashBoardContainer(
                  'soldAmount',
                  Icons.published_with_changes_outlined,
                  Color.fromARGB(255, 4, 151, 110),
                  totalSold.toString(),
                  'Worth of stocks has been sold',
                  Color.fromARGB(255, 236, 229, 229),
                ),
                DashBoardContainer(
                  'currentAmount',
                  Icons.star_purple500_sharp,
                  Color.fromARGB(255, 4, 151, 110),
                  currentValuation.toString(),
                  'Current valuation of stocks',
                  Color.fromARGB(255, 236, 229, 229),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DashBoardContainer(
                  'profit',
                  Icons.money_rounded,
                  Color.fromARGB(255, 4, 151, 110),
                  (currentValuation - capitalInvested).toString(),
                  'All time profits made through this app',
                  Color.fromARGB(255, 236, 229, 229),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget DashBoardContainer(
      String containerName,
      IconData containerIcon,
      Color iconColor,
      String amount,
      String description,
      Color containerColor) {
    String addRs = 'Rs.';

    if (containerName == 'totalUnits') {
      addRs = '';
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(
                containerIcon,
                color: iconColor,
                size: 40,
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            addRs + amount,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description.sentenceCase,
            style: TextStyle(
              color: Color.fromARGB(255, 134, 133, 133),
            ),
          ),
        ],
      ),
    );
  }

  String getInitials(String bankName) => bankName.isNotEmpty
      ? bankName.trim().split(RegExp(' +')).map((s) => s[0]).take(3).join()
      : '';
}
