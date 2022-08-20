import 'package:flutter/material.dart';

class CommonLayout extends StatefulWidget {
  const CommonLayout({Key? key}) : super(key: key);

  @override
  State<CommonLayout> createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  String dropdownValue = 'Client';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 65,
          child: InputDecorator(
            decoration: inputDecor('Choose a Stock'),
            child: DropdownButton<String>(
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
                });
              },
              items: <String>['Client', 'Trainer'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
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
