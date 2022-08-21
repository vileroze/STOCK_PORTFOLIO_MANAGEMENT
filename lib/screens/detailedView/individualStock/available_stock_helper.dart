import 'package:flutter/material.dart';
import 'package:portfolio_management/screens/detailedView/individualStock/individual_stock.dart';
import 'package:recase/recase.dart';

class StocksHelper {
  void addRowsToList(
    List<GestureDetector> tileGestureDetector,
    String stockName,
    BuildContext context,
    Size size,
  ) {
    tileGestureDetector.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    IndividualStockDetail(stockName.titleCase)),
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
                  getInitials(stockName.titleCase),
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
                stockName.titleCase,
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
}

String getInitials(String bankName) => bankName.isNotEmpty
    ? bankName.trim().split(RegExp(' +')).map((s) => s[0]).take(3).join()
    : '';
