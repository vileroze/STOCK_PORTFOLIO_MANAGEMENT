import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recase/recase.dart';
import 'individualStock/individual_stock.dart';

class AllStocks extends StatefulWidget {
  const AllStocks({Key? key}) : super(key: key);

  @override
  State<AllStocks> createState() => _AllStocksState();
}

class _AllStocksState extends State<AllStocks> {
  final _database = FirebaseDatabase.instance.ref();
  final tilesContainer = <GestureDetector>[];
  List<String> stockNameArr = [];

  @override
  void initState() {
    super.initState();
    _getAllStockName();
  }

  void _getAllStockName() {
    _database.child('transactions/').onValue.listen((event) {
      final alltransaction = Map<dynamic, dynamic>.from(
          ((event.snapshot.value) as Map<dynamic, dynamic>));

      alltransaction.forEach((key, value) {
        final indTransaction = Map<dynamic, dynamic>.from(value);

        if (indTransaction['type'] == 'Buy' &&
            !stockNameArr.contains(indTransaction['stock_name'])) {
          stockNameArr.add(indTransaction['stock_name'].toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    for (String stock in stockNameArr) {
      tilesContainer.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IndividualStockDetail(stock.titleCase)),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 30, right: 30),
            height: 80,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 6, 204, 148),
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: size.width / 13,
                  backgroundColor: Color.fromARGB(255, 4, 151, 110),
                  child: Text(
                    getInitials(stock.titleCase),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  stock.titleCase,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: size.height / 1.5,
      child: ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: tilesContainer),
    );
  }

  String getInitials(String bankName) => bankName.isNotEmpty
      ? bankName.trim().split(RegExp(' +')).map((s) => s[0]).take(3).join()
      : '';
}
