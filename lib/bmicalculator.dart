import 'package:flutter/material.dart';
import 'historypage.dart';

class MainPage extends StatefulWidget{
  BMIpage createState()=> BMIpage();
}

class BMIpage extends State<MainPage> {

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("photo/pexels-pixabay-255501.jpg"),
                  fit: BoxFit.cover)
          ),
          width: 350,
          child: Card(
            color: Colors.white70,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    controller: _heightController,
                  ),
                  TextField(
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Weight (kg)',
                    ),
                    controller: _weightController,
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.greenAccent,
                    onPressed: calculate,
                    child: Text('Calculate'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Text(
                      _bmi == null ? '' : _bmi!.toStringAsFixed(2),
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      _message,
                      style: TextStyle(fontSize: 20, color: Colors.grey.withOpacity(1)),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyTextPage()),
          );
        },
        child: Icon(Icons.history),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

  void calculate() {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("WARNING !"),
      content: Text("Your weight is greater than what is considered healthy."),
      actions: [
        okButton,
      ],
    );
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;
    _bmi = result;
    setState(() {
      if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'You body is fine';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        _message = 'You are obese';
        showDialog(context: context, builder: (BuildContext context) {
          return alert;
        },
        );
      }
    });
  }
}
