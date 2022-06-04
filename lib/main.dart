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
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Your weight is greater than what is considered healthy."),
      content: Text("Please Click the green button below to see healthy food recipes."),
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

class PhotoItem {
  final String image;
  final String name;
  PhotoItem(this.image, this.name);
}

class SecondRoute extends StatelessWidget {

  final List<PhotoItem> images = [
    PhotoItem("photo/1.jpg", "Chicken Satay salad"),
    PhotoItem("photo/2.jpg", "Linguine with avocado"),
    PhotoItem("photo/3.jpg", "Pork souvlaki"),
    PhotoItem("photo/4.jpg", "Salsa verde"),
    PhotoItem("photo/5.jpg", "Roasted cod"),
    PhotoItem("photo/6.jpg", "Pomegranate"),
    PhotoItem("photo/7.jpg", "Tuna Spaghetti"),
    PhotoItem("photo/8.jpg", "Turmeric, fish curry"),
    PhotoItem("photo/9.jpg", "Crispy grilled feta"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Healthy Food Recommend"),
          backgroundColor: Colors.blue,
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 3,
          ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RouteTwo(
                        image: images[index].image, name: images[index].name),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(images[index].image),
                  ),
                ),
              ),
            );
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.home_filled),
          backgroundColor: Colors.green,
        ),
      );
  }
}

class RouteTwo extends StatelessWidget {
  final String image;
  final String name;

  RouteTwo({Key? key, required this.image, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recieves'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage(image),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}