import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Stopwatch App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StopWatchScreen(),
    );
  }
}

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  String hoursString = "00", minutesString = "00", secondsString = "00";

  int hours = 0, minutes = 0, seconds = 0;
  bool isTimerRunning = false;
  bool isResetButtonVisible = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      isTimerRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _startSeconds();
    });
  }

  void pauseTimer() {
    _timer.cancel();

    setState(() {
      isTimerRunning = false;
    });
    isResetButtonVisible = checkValues();
  }

  void resetTimer() {
    _timer.cancel();

    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      secondsString = "00";
      minutesString = "00";
      hoursString = "00";

      isResetButtonVisible = false;
    });
  }

  bool checkValues() {
    if (seconds != 0 || minutes != 0 || hours != 0) {
      return true;
    } else {
      return false;
    }
  }

  void _startSeconds() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondsString =
            seconds.toString(); //converting seconds variable value to String

        if (secondsString.length == 1) {
          secondsString = "0" + secondsString;
        }
      } else {
        _startMinute();
      }
    });
  }

  void _startMinute() {
    setState(() {
      if (minutes < 59) {
        seconds = 0;
        secondsString = "00";
        minutes++;
        minutesString = minutes.toString();

        if (minutesString.length == 1) {
          minutesString = "0" + minutesString;
        }
      } else {
        _startHours();
      }
    });
  }

  void _startHours() {
    setState(() {
      seconds = 0;
      minutes = 0;
      secondsString = "00";
      minutesString = "00";
      hours++;
      hoursString = hours.toString();

      if (hoursString.length == 1) {
        hoursString = "0" + hours.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 184, 238),
      appBar: AppBar(
        title: const Text(
          "Stop Watch App",
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.watch),
        actions: [Icon(Icons.watch)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "$hoursString:$minutesString:$secondsString",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
            ),
          ),

          //1st button to pause and play timer
          ElevatedButton(
              onPressed: () {
                if (isTimerRunning) {
                  pauseTimer();
                } else {
                  startTimer();
                }
              },
              child: Text(isTimerRunning ? "pause" : "start")),

          const SizedBox(
            height: 20,
          ),

          //2nd button to reset timer
          isResetButtonVisible
              ? ElevatedButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Text("Reset"))
              : SizedBox(),
        ],
      ),
    );
  }
}


//video link:https://www.youtube.com/watch?v=TpSh1X4DdII&list=LL&index=1
//channelName:Aditya chaudry