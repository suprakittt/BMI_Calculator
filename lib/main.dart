import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'BMI calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(children: <Widget>[
        Text(
          'Height (cm)',
        ),
        TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.trending_up),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'weight (kg)',
        ),
        TextField(
          decoration: InputDecoration(
//              labelText: 'weight (kg)',
            icon: Icon(Icons.line_weight),
          ),
        ),
        SizedBox(height: 15),
        RaisedButton(
          color: Colors.deepPurple,
          child: Text(
            "Calculate",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: calculate,
        ),
        SizedBox(height: 15),
        Text(
          _result == null ? "BMI" : "${_result?.toStringAsFixed}",
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 19.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }

  void calculate() {
    double height = double.parse(_heightController.text) / 100;
    double weight = double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;
    _result = result;
    setState(() {});
  }
}
