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
      title: Text("WARNING !"),
      content: Text("Your weight is greater than what is considered healthy. \nPlease Click the green button below to see healthy food recipes."),
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
    PhotoItem("photo/1.jpg", "Banana & tahini porridge\n\n- 1tbsp tamari\n- 1 tbsp tahini\n- 150ml milk of your choice, plus 1 tbsp\n- 100g porridge oats\n- 2 small bananas , sliced\n- seeds from 2 cardamom pods, crushed\n- 1 tbsp toasted sesame seeds"),
    PhotoItem("photo/2.jpg", "Overnight oats\n\n- ¼ tsp ground cinnamon\n- 50g rolled porridge oats\n- 2 tbsp natural yogurt\n- 50g mixed berries\n  drizzle of honey\n- ½ tbsp nut butter "),
    PhotoItem("photo/3.jpg", "Burrito\n\n- 1 tsp chipotle paste\n- 1 egg\n- 1 tsp rapeseed oil\n- 50g kale\n- 7 cherry tomatoes, halved\n- ½ small avocado, sliced\n- 1 wholemeal tortilla wrap, warmed"),
    PhotoItem("photo/4.jpg", "Healthy pancakes\n\n- 50g self-raising flour\n- 50g wholemeal or wholegrain flour\n- 2 small eggs, separated\n- 150ml skimmed milk\n- berries and low-fat yogurt or fromage frais to serve"),
    PhotoItem("photo/5.jpg", "Slow cooker bio yogurt\n\n- 2l whole milk\n- 100ml live yogurt , either shop bought or from a previous homemade batch"),
    PhotoItem("photo/6.jpg", "Baked banana porridge\n\n- 2 small bananas , halved lengthways\n- 100g jumbo porridge oats\n- ¼ tsp cinnamon\n- 150ml milk of your choice, plus extra to serve\n- 4 walnuts , roughly chopped"),
    PhotoItem("photo/7.jpg", "Green fritters\n\n- 140g courgettes , grated\n- 3 medium eggs\n- 85g broccoli florets, finely chopped\n- small pack dill , roughly chopped\n- 3 tbsp gluten-free flour or rice flour\n- 2 tbsp sunflower oil , for frying"),
    PhotoItem("photo/8.jpg", "Saucy bean baked eggs\n\n- 2 x 400g cans cherry tomatoes\n- 400g can mixed bean salad , drained\n- 200g baby spinach\n- 4 medium eggs\n- 50g thinly sliced smoked ham , torn"),
    PhotoItem("photo/9.jpg", "Avocado & strawberry smoothie\n\n- ½ avocado , stoned, peeled and cut into chunks\n- 150g strawberry , halved\n- 4 tbsp low-fat natural yogurt\n- 200ml semi-skimmed milk\n- lemon or lime juice , to taste\n- honey , to taste"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
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
        backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage(image),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue[100]),
              margin: const EdgeInsets.all(10.0) ,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("photo/textbg.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            margin: const EdgeInsets.all(40.0),
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.green,
      ),
    );
  }
}