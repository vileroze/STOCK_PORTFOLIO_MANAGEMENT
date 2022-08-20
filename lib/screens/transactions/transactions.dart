import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:portfolio_management/screens/transactions/transaction_builder.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _database.child('transactions/aaaaa/').onValue.listen((event) {
      // print(event.snapshot.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 151, 110),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                      ),
                      child: Text(
                        'Transactions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width / 20,
                          color: Color.fromARGB(255, 19, 51, 89),
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(child: AllTransactions()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
