import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonLayout extends StatefulWidget {
  final String type;
  CommonLayout(this.type);

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  String dropdownValue = 'Standard Chartered Bank';
  final String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late StreamSubscription _userTypeStream;
  final _database = FirebaseDatabase.instance.ref();
  bool isBuy = true;
  int totalUnits = 0;

  List<String> stockNameArr = [];
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllStockName();
  }

  void _getAllStockName() {
    if (widget.type == 'BuyPage') {
      _database.child('allStocks/').onValue.listen((event) {
        final allStocks = Map<dynamic, dynamic>.from(
            ((event.snapshot.value) as Map<dynamic, dynamic>));

        allStocks.forEach((key, value) {
          stockNameArr.add(key);
        });
      });
    } else if (widget.type == 'SellPage') {
      _database.child('transactions/').onValue.listen((event) {
        final alltransaction = Map<dynamic, dynamic>.from(
            ((event.snapshot.value) as Map<dynamic, dynamic>));

        alltransaction.forEach((key, value) {
          final indTransaction = Map<dynamic, dynamic>.from(value);

          // print(indTransaction['stock_name'].toString());
          if (indTransaction['type'] == 'Buy' &&
              !stockNameArr.contains(indTransaction['stock_name'])) {
            stockNameArr.add(indTransaction['stock_name'].toString());
          }

          // print(key);
          // stockNameArr.add(key);
        });
      });
    }
    print('tttttttttttttttttt');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'SellPage') {
      isBuy = false;
    }

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isBuy ? 'BUY STOCKS' : 'SELL STOCKS',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 4, 151, 110),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 15,
            ),
            Icon(Icons.line_axis, color: Color.fromARGB(255, 4, 151, 110))
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 65,
          child: InputDecorator(
            decoration: inputDecor('Choose a Stock'),
            child: DropdownButton<String>(
              dropdownColor: Color.fromARGB(255, 4, 151, 110),
              // style: TextStyle(color: Colors.white),
              value: dropdownValue,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 0,
              underline: Container(
                height: 0,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;

                  totalUnits = 0;
                  _userTypeStream =
                      _database.child('transactions/').onValue.listen((event) {
                    final alltransaction = Map<dynamic, dynamic>.from(
                        ((event.snapshot.value) as Map<dynamic, dynamic>));
                    alltransaction.forEach((key, value) {
                      final indTransaction = Map<dynamic, dynamic>.from(value);

                      if (indTransaction['stock_name'] == dropdownValue) {
                        if (indTransaction['type'] == 'Buy') {
                          // print('Buyyyyyyyyyyyyy -   ' +
                          //     indTransaction['quantity'].toString());
                          setState(() {
                            totalUnits += indTransaction['quantity'] as int;
                          });
                        } else {
                          // print('Soldddddddddd -   ' +
                          //     indTransaction['quantity'].toString());
                          setState(() {
                            totalUnits -= indTransaction['quantity'] as int;
                          });
                        }
                      }
                    });
                  });
                });
              },
              items: stockNameArr.map((String option) {
                print('rrrrrrrrrrrrrrrrrrr');
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Text(
            'Number of units you own of this stock: ' +
                totalUnits.toString() +
                ' units',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.red[700]),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 65,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            style: const TextStyle(color: Colors.black),
            controller: unitController,
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Price can\'t be empty';
              }
            },
            decoration: inputDecor('Number of units '),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 65,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            controller: priceController,
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Price can\'t be empty';
              }
            },
            decoration: inputDecor('Price per unit'),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(isBuy
                ? Color.fromARGB(255, 4, 151, 110)
                : Color.fromARGB(255, 197, 18, 18)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            final newTransaction = <String, dynamic>{
              'amount': (int.parse(priceController.text) *
                  int.parse(unitController.text)),
              'date': todayDate.toString(),
              'quantity': int.parse(unitController.text),
              'stock_name': dropdownValue.toString(),
              'type': widget.type == 'SellPage' ? 'Sell' : 'Buy',
            };

            _database
                .child('transactions')
                .push()
                .set(newTransaction)
                .then((value) {
              Fluttertoast.showToast(
                  msg: "Transaction Complete!", // message
                  toastLength: Toast.LENGTH_SHORT, // length
                  gravity: ToastGravity.CENTER, // location
                  timeInSecForIosWeb: 1,
                  backgroundColor: Color.fromARGB(255, 4, 151, 110),
                  textColor: Colors.white,
                  fontSize: 16.0 // duration
                  );
            }).catchError(
              (error) => print(
                  '!!!!!!! Error while adding new transaction: $error !!!!!!!'),
            );
            totalUnits = 0;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              isBuy ? 'CONFIRM BUY ORDER' : 'CONFIRM SELL ORDER',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration inputDecor(String hint) {
    return InputDecoration(
      filled: false,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Color.fromARGB(255, 4, 151, 110)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Color.fromARGB(255, 4, 151, 110)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(color: Color.fromARGB(255, 4, 151, 110)),
      ),
      labelText: hint,
      labelStyle: TextStyle(color: Color.fromARGB(255, 4, 151, 110)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
