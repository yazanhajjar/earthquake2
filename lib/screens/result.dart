import 'package:earthquake_protection/models/the_question.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Resultscreen extends ConsumerWidget {
  const Resultscreen(
      {super.key, required this.answers, required this.questions});
  final List<String> answers;
  final List<Question> questions;

  get summary {
    List<Map<String, Object>> summaryresult = [];
    for (int i = 0; i < questions.length; i++) {
      summaryresult.add({
        'index': i + 1,
        'question': questions[i].thequestion,
        'correctAnswer': questions[i].answer[0],
        'userAnswer': answers[i]
      });
    }
    return summaryresult;
  }

  get numcorrect {
    int num = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].answer[0] == answers[i]) {
        num++;
      }
    }
    return num;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int languagenumber = ref.read(languagenumberProvider);
        int size=ref.read(textsizeProvider);


    return Scaffold(
      appBar: AppBar(
          title: Text(
            languagenumber == 0 ? 'The Result' : 'النتيجة',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  languagenumber == 0
                      ? 'You answerd $numcorrect correct of ${questions.length} '
                      : 'لقد أجبت بشكل صحيح على $numcorrect من ${questions.length}',
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                      fontSize: 30+size.toDouble(), fontWeight: FontWeight.bold)),
              ...summary.map((e) => Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: e['index'] % 2 == 0
                          ? Theme.of(context).colorScheme.onPrimaryFixedVariant
                          : Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      children: [
                        CircleAvatar(
                          backgroundColor: e['userAnswer'] == e['correctAnswer']
                              ? const Color.fromARGB(255, 196, 182, 136)
                              : const Color.fromARGB(255, 90, 62, 60),
                          child: Text(
                            e['index'].toString(),
                            textAlign: TextAlign.center,
                            style:  TextStyle(color: Colors.white,fontSize: 15+size.toDouble()),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              languagenumber == 0
                                  ? 'The question : ${e['question']}'
                                  : 'السؤال : ${e['question']}  ',
                              style: TextStyle(
                                  fontSize: 22+size.toDouble(),
                                  color: Theme.of(context).colorScheme.onSecondary,
                                  // color: e['index'] % 2 != 0
                                  //     ? const Color.fromARGB(255, 113, 113, 113)
                                  //     : const Color.fromARGB(255, 5, 4, 4),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                                languagenumber == 0
                                    ? 'The correct Answer : ${e['correctAnswer']}'
                                    : 'الإجابة الصحيحة : ${e['correctAnswer']}',
                                style:  TextStyle(
                                    fontSize: 20+size.toDouble(),
                                    color: Color.fromARGB(255, 252, 234, 175)),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            Text(
                                languagenumber == 0
                                    ? 'your Answer : ${e['userAnswer']}'
                                    : 'إجابتك: ${e['userAnswer']}',
                                style:  TextStyle(
                                    fontSize: 20+size.toDouble(), color: Colors.white),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 50, 41, 41)),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text(
                    languagenumber == 0
                        ? 'Go to home page'
                        : 'العودة للصفحة الرئيسية',
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
