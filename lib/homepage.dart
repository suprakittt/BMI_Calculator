import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'bmicalculator.dart';
import 'homepage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _duration = 300;
  final CountDownController _controller = CountDownController();

//  final _heightController = TextEditingController();
//  final _weightController = TextEditingController();
//  double? _bmi;
//  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(

          child:
          CircularCountDownTimer(
            duration: _duration,
            initialDuration: 0,
            controller: _controller,
            width: MediaQuery
                .of(context)
                .size
                .width / 2,

            height: MediaQuery
                .of(context)
                .size
                .height / 2,

            ringColor: Colors.grey[300]!,
            ringGradient: null,

            fillColor: Colors.blueAccent[100]!,
            fillGradient: null,
            backgroundColor: Colors.blue[500],
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
              fontSize: 33.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.S,
            isReverse: false,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false,
          )

      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          _button(title: "Start", onPressed: () => _controller.start()
          ),

          const SizedBox(
            width: 5,
          ),
          _button(title: "Stop", onPressed: () => _controller.pause()),
          const SizedBox(
            width: 5,
          ),
          _button(
              title: "Reset",
              onPressed: () => _controller.restart(duration: _duration)),
          const SizedBox(
            width: 5,
          ),
          _button(
            title: "BMI",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },),
        ],
      ),

    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
        child: ElevatedButton(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
          ),
          onPressed: onPressed,
        ));
  }
}