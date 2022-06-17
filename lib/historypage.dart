import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'bmicalculator.dart';

class MyTextPage extends StatelessWidget {
  List history = GetStorage().read("History") ?? [];
  TextStyle? _style = TextStyle(fontSize: 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI History")),
      body: Column(
        children: <Widget>[
        Container(
        height: 60.0,
        child: Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                width: 142.0,
                child: Text(
                  "Height",
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                padding: EdgeInsets.all(10),
                width: 150.0,
                child: Text(
                  "Weight",
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                padding: EdgeInsets.all(10),
                width: 100.0,
                child: Text(
                  "BMI",
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
      Expanded(child: ListView.builder(
        itemCount: history.length,
        itemBuilder: ((context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(history[index]["height"], style: _style),
            Text(history[index]["weight"], style: _style),
            Text(history[index]["result"], style: _style),
          ],

        )),
      )

      ),
    ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
