import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      title: 'Quizy',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> scoreKeeper = [];

  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  //
  // List<bool> answers = [false, true, true];

  void checkAnswer(bool userCheckedAnswer) {
    setState(() {
      if (scoreKeeper.length == quizBrain.getQuestionBankLength()) {
        Alert(
                context: context,
                title: 'QUIZ COMPLETED',
                desc: 'You have successfully completed the quiz.')
            .show();
        quizBrain.resetQuiz();
        scoreKeeper.clear();
      } else {
        if (!(userCheckedAnswer == quizBrain.getQuestionAnswer())) {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    color: Colors.green,
                    child: TextButton(
                      child: const Text(
                        'True',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        checkAnswer(true);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    color: Colors.red,
                    child: TextButton(
                        child: const Text(
                          'False',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          checkAnswer(false);
                        }),
                  ),
                ),
              ),
              Row(
                children: scoreKeeper,
              )
            ],
          ),
        ),
      ),
    );
  }
}
