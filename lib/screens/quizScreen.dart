import 'package:flutter/material.dart';
import 'dart:io';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Widget Options(String op, int selected) {
    return GestureDetector(
      onTap: () {
        if (!isNext) {
          setState(() {
            selectedOption = selected;
          });
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: highlightAnswer
              ? BorderSide(
                  color: op == questions[currIndex]['ans']
                      ? Colors.green
                      : selectedOption == selected
                          ? Colors.red
                          : Colors.grey[400],
                  width: 1.5)
              : BorderSide(
                  color: selectedOption == selected
                      ? Colors.blue[300]
                      : Colors.grey[400],
                  width: 1.5),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 35,
          width: double.infinity,
          child: Center(
            child: FittedBox(
              child: Text(op,style: TextStyle(fontSize: 18),),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget retry = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        setState(() {
          selectedOption = -1;
          points = 0;
          currIndex = 0;
          highlightAnswer=false;
          isNext=false;
          Navigator.of(context).pop();
        });
      },
    );
    Widget Exit = FlatButton(
      child: Text("Exit"),
      onPressed: () => exit(0),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Well Done!",
        textAlign: TextAlign.center,
      ),
      content: Text('Final Score : $points',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
      actions: [
        retry,
        Exit,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Map<String, dynamic>> questions = [
    {
      'ques': ' Entomology is the science that studies',
      'options': [
        'Behaviour of human beings',
        'Insects',
        'The origin and history of technical and scientific terms',
        'The formation of rocks',
      ],
      'ans': 'Insects'
    },
    {
      'ques': 'Galileo was an astronomer who',
      'options': [
        'developed the telescope',
        'discovered four satellites of Jupiter',
        ' discovered pendulum produces a regular time measurement',
        'All the above.',
      ],
      'ans': 'discovered four satellites of Jupiter'
    },
    {
      'ques':
          'Which one of the following was the first fort constructed by the British in India?',
      'options': [
        'Fort William',
        'Fort St. George',
        'Fort St. David',
        'Fort St. Angelo',
      ],
      'ans': 'Fort St. George'
    },
    {
      'ques': 'What is the second largest country (in size) in the world?',
      'options': [
        'Canada',
        'USA',
        'China',
        'Russia',
      ],
      'ans': 'Canada'
    },
    {
      'ques': 'The currency notes are printed in',
      'options': [
        'New Delhi',
        'Nasik',
        'Nagpur',
        'Bombay',
      ],
      'ans': 'Nasik'
    },
    {
      'ques': 'Tsunamis are not caused by',
      'options': [
        'Hurricanes',
        'Earthquakes',
        'Undersea landslides',
        'Volcanic eruptions',
      ],
      'ans': 'Hurricanes'
    },
    {
      'ques': 'The hottest planet in the solar system?',
      'options': [
        'Mercury',
        'Venus',
        'Mars',
        'Jupiter',
      ],
      'ans': 'Venus'
    },
    {
      'ques': 'Which one of the following ports is the oldest port in India?',
      'options': [
        'Mumbai Port',
        'Chennai Port',
        'Kolkata Port',
        'Vishakhapatnam Port',
      ],
      'ans': 'Chennai Port'
    },
    {
      'ques': 'Which of the following is not a nuclear power center?',
      'options': [
        'Narora',
        'Kota',
        'Chamera',
        'Kakrapara',
      ],
      'ans': 'Chamera'
    },
    {
      'ques': 'Objects at the surface of water can be viewed from a submarine under water by using this instrument.',
      'options': [
        'Stethescope',
        'Periscope',
        'Kaleidoscope',
        'Telescope',
      ],
      'ans': 'Periscope'
    },
  ];

  var currIndex = 0;
  var selectedOption = -1;
  bool isNext = false;
  bool highlightAnswer = false;
  int points = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('G.K Quiz'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                questions[currIndex]['ques'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    Options(questions[currIndex]['options'][0], 0),
                    Options(questions[currIndex]['options'][1], 1),
                    Options(questions[currIndex]['options'][2], 2),
                    Options(questions[currIndex]['options'][3], 3),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Builder(
                builder: (ctx) => RaisedButton(
                  onPressed: () {
                    if (isNext) {
                      if ((currIndex + 1) == questions.length) {
                        showAlertDialog(context);
                      } else {
                        setState(() {
                          currIndex = (currIndex + 1) % questions.length;
                          selectedOption = -1;
                          isNext = false;
                          highlightAnswer = false;
                        });
                      }
                      return;
                    }

                    if (selectedOption == -1) {
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Please select an option'),
                        ),
                      );
                      return;
                    }
                    String correctAns = questions[currIndex]['ans'];
                    String selectedAns =
                        questions[currIndex]['options'][selectedOption];
                    if (correctAns == selectedAns) {
                      points += 2;
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          backgroundColor: Colors.green,
                          content: Text('Correct'),
                        ),
                      );
                      if ((currIndex + 1) == questions.length) {
                        showAlertDialog(context);
                      } else {
                        //move to next question
                        setState(() {
                          currIndex = (currIndex + 1) % questions.length;
                          selectedOption = -1;
                        });
                      }
                    } else {
                      points -= 1;
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          backgroundColor: Colors.red,
                          content: Text('Wrong'),
                        ),
                      );

                      //show the correct answer
                      //display next button
                      setState(() {
                        highlightAnswer = true;
                        isNext = true;
                      });
                      //change question when clicked again
                    }
                  },
                  child: Text(
                    isNext ? 'Next' : 'Submit',
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Text('Your Points : $points')
            ],
          ),
        ),
      ),
    );
  }
}
