import 'package:flutter/material.dart';
import 'package:portfolio_management/screens/detailedView/available_stocks_builder.dart';

class AvailableStocks extends StatefulWidget {
  const AvailableStocks({Key? key}) : super(key: key);

  @override
  State<AvailableStocks> createState() => _AvailableStocksState();
}

class _AvailableStocksState extends State<AvailableStocks> {
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
          'AVAILABLE STOCKS',
          style: TextStyle(
            fontSize: size.width / 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
            letterSpacing: 2.0,
            color: Color.fromARGB(255, 4, 151, 110),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                // color: Color.fromARGB(255, 4, 151, 110),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: AllStocks(),
      ),
    );
  }
}
