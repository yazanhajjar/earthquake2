import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/userplan.dart';
import 'package:earthquake_protection/screens/plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Apperplan extends ConsumerWidget {
  const Apperplan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> planAnswer = ref.watch(planProvider);
    bool mode = ref.read(lightProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Plan',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : const Color.fromRGBO(0, 180, 216, 1),
      ),
      backgroundColor: mode
          ? Theme.of(context).colorScheme.primary
          : Color.fromRGBO(202, 240, 248, 1),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s make your Plan ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(78.0), 
              child: Image.asset(
                r'lib\images\Earthquake.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (planAnswer == []) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Warning'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'you do not have plan yet ,create one'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: mode
                                  ? Theme.of(context).colorScheme.primary
                                  : Color(0xf0f0f0f0),
                              title: Text('Your Plan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...planAnswer.map((answer) => Column(
                                          children: [
                                            Text(answer),
                                            Divider(
                                              color: mode
                                                  ? Colors.white70
                                                  : Colors.black26,
                                            )
                                          ],
                                        )),
                                    SizedBox(height: 20),
                                    ...valueQuestions.map((question) => Column(
                                          children: [
                                            Text(
                                                '$question: ${valueAnswers[question]}'),
                                            Divider(
                                              color: mode
                                                  ? Colors.white70
                                                  : Colors.black26,
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        color:
                                            mode ? Colors.white : Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.secondaryFixed)),
                      child: Text('display your plan')),
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.secondaryFixed)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Quizplan(),
                            ));
                      },
                      child: Text('create plan')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
