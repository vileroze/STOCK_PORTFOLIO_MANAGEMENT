import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:portfolio_management/screens/detailedView/individualStock/available_stock_helper.dart';
import 'package:recase/recase.dart';
import 'individualStock/individual_stock.dart';

class AllStocks extends StatefulWidget {
  const AllStocks({Key? key}) : super(key: key);

  @override
  State<AllStocks> createState() => _AllStocksState();
}

class _AllStocksState extends State<AllStocks> {
  final _database = FirebaseDatabase.instance.ref();
  // List<String> stockNameArr = [];
  // List<GestureDetector> tilesContainer = [];
  final helperClass = StocksHelper();
  final tilesContainer = <GestureDetector>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: _database.child('transactions/').onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            final allTrasaction = Map<dynamic, dynamic>.from(
                ((snapshot.data! as DatabaseEvent).snapshot.value ?? {})
                    as Map<dynamic, dynamic>);

            allTrasaction.forEach(
              (key, value) {
                final individualTrasaction = Map<String, dynamic>.from(value);
                if (individualTrasaction['type'] == 'Buy') {
                  helperClass.addRowsToList(
                    tilesContainer,
                    individualTrasaction['stock_name'].toString(),
                    context,
                    size,
                  );
                }
              },
            );
          }
        }
        return SizedBox(
          height: size.height / 1.5,
          child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: tilesContainer),
        );
      },
    );
  }
}
