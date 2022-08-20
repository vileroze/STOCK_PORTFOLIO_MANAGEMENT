import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:portfolio_management/screens/transactions/transaction_helper.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  final _database = FirebaseDatabase.instance.ref();
  final tilesContainer = <Container>[];
  final helperClass = TransactionHelper();

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
                // print('--------------------   ' +
                //     individualTrasaction.toString());

                helperClass.addRowsToList(
                  tilesContainer,
                  individualTrasaction['amount'].toString(),
                  individualTrasaction['date'].toString(),
                  individualTrasaction['quantity'].toString(),
                  individualTrasaction['stock_name'].toString(),
                  individualTrasaction['type'].toString(),
                );
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
