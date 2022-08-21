import 'package:flutter/material.dart';
import 'package:portfolio_management/screens/detailedView/available_stocks.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:recase/recase.dart';
import 'package:firebase_database/firebase_database.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
    // _getAllTimeProfit();
  }

  void _getNumberOfStocks() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));
      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

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
      });
    });
  }

  void _getCapitalInvested() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));
      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

        if (indTransaction['type'] == 'Buy') {
          // print('Buyyyyyyyyyyyyy -   ' + indTransaction['amount'].toString());
          setState(() {
            capitalInvested += indTransaction['amount'] as int;
          });
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

        if (indTransaction['type'] == 'Sell') {
          // print('Buyyyyyyyyyyyyy -   ' + indTransaction['amount'].toString());
          setState(() {
            totalSold += indTransaction['amount'] as int;
          });
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
      });
    });
  }

  // void _getAllTimeProfit() {
  //   setState(() {
  //     print(currentValuation.toString() +
  //         '---------------' +
  //         capitalInvested.toString());

  //     totalProfit = currentValuation - capitalInvested;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
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
        const SizedBox(
          height: 80,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 4, 151, 110)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                    width: 3.0, color: Color.fromARGB(255, 4, 151, 110)),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AvailableStocks()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Wrap(
              children: [
                Text(
                  'VIEW DETAILS',
                  style: TextStyle(fontSize: 20, letterSpacing: 1),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
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
}
