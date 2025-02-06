import 'package:earthquake_protection/models/the_question.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:earthquake_protection/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Quizscreen extends ConsumerStatefulWidget {
  const Quizscreen({super.key, required this.question, required this.title});
  final List<Question> question;
  final String title;

  @override
  ConsumerState<Quizscreen> createState() => _QuizscreenState();
}

class _QuizscreenState extends ConsumerState<Quizscreen> {
  int questionNumber = 0;
  List<String> userAnswer = [];
  List<String> randomAnswers = [];

  String get currentQuestion {
    return widget.question[questionNumber].thequestion;
  }

  List<String> get shufflingAnswer {
    randomAnswers = List.of(widget.question[questionNumber].answer);
    randomAnswers.shuffle();
    return randomAnswers;
  }

  @override
  Widget build(BuildContext context) {
    int size = ref.read(textsizeProvider);
    bool mode=ref.read(lightProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:mode? Theme.of(context).colorScheme.secondaryFixedDim:const Color.fromRGBO(0, 180, 216, 1),
        title: Title(
            color: Theme.of(context).colorScheme.onSurface,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30+size.toDouble(), fontWeight: FontWeight.bold),
            )),
      ),
      backgroundColor: mode?Theme.of(context).colorScheme.primary: Color.fromRGBO(202, 240, 248,1),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                currentQuestion,
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25+size.toDouble(),
                    color: Color.fromARGB(255, 43, 6, 6)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ...shufflingAnswer.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            userAnswer.add(e);
                            setState(() {
                              if (questionNumber < widget.question.length - 1) {
                                questionNumber++;
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => Resultscreen(
                                              questions: widget.question,
                                              answers: userAnswer,
                                            )));
                              }
                            });
                          },
                          style:  ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                mode?  Color.fromARGB(255, 50, 41, 41):Color.fromRGBO(2, 62, 138, 1)),
                              padding:
                                  WidgetStatePropertyAll(EdgeInsets.all(20))),
                          child: Text(
                            e,
                            style:  TextStyle(
                                fontSize: 25+size.toDouble(),
                                color: Color.fromARGB(255, 202, 171, 171)),
                          )),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
