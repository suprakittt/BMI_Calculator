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
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
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
              color: Colors.white,
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
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
          child: Icon(Icons.flatware),
          backgroundColor: Colors.green,
        ),
    );
  }

  void calculate() {
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
      } else {
        _message = 'You are obese';
      }
    });
  }
}

class SecondRoute extends StatelessWidget {

  List<String> images = [
    "photo/1.jpg",
    "photo/2.jpg",
    "photo/3.jpg",
    "photo/4.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Healthy Food Recommend"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0
              ),
              itemBuilder: (BuildContext context, int index){
                return Image.asset(images[index]);
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.home_filled),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}