import 'package:flutter/material.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: Mainpage(),
  ));
}

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  TextEditingController datecontrol = TextEditingController();
  int? days;
  int? months;
  int? years;
  String? finaldate;
  String? currentdate;
  DateTime? selecteddate;
  DateTime? display;
  DateDuration? ans;
  var agecounted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
            child: Text(finaldate==null?
              "" : "$finaldate",
                style: TextStyle(fontSize: 22),
            ),
          ),
          InkWell(
            onTap: () async {
              DateTime? selecteddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));

              if (selecteddate != null) {
                print("selecteddate==$selecteddate");
                 setState(() {
                   finaldate = DateFormat('dd-MM-yyyy').format(selecteddate);
                 });

                  ans = AgeCalculator.age(selecteddate, today: DateTime.now());

                  days= ans!.days;
                  months= ans!.months;
                  years = ans!.years;
                  print("Seprating age-------\n----------Days = $days, Months = $months, Years = $years");

              }
            },
            child: Container(
              height: 30,
              width: 150,
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text(
                "Select date",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            alignment: Alignment.center,
            color: Colors.white54,
            child: Text("$agecounted"),
          ),
          InkWell(onTap: () {
            setState(() {
              agecounted=ans;
              print("age counted=====$agecounted");
            });
          },
            child: Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              height: 40,
              width: 150,
              color: Colors.orange,
              child: Text("Calculate"),
            ),
          ),
        ],
      ),
    );
  }
}
