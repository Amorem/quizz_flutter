import 'package:flutter/material.dart';
import 'package:quizzler/quizBrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

QuizBrain quizBrain = QuizBrain();

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  
  int questionsIndex = 0;

  void updateProgress() {
    if (questionsIndex < quizBrain.questions.length - 1)
      setState(() {
        questionsIndex = questionsIndex + 1;
      }) else {questionsIndex = questionsIndex;}
  }

  bool isCorrect(bool userAnswer) {
    if (userAnswer == quizBrain.questions[questionsIndex].questionAnswer) {
      scoreKeeper.add(Icon(
        Icons.mood,
        color: Colors.green,
      ));
      return true;
    } else {
      scoreKeeper.add(Icon(
        Icons.mood_bad,
        color: Colors.red,
      ));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questions[questionsIndex].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                isCorrect(true);
                updateProgress();
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                isCorrect(false);
                updateProgress();
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
