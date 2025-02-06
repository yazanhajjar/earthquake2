import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/userplan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> yesNoQuestions = [
  'Do you have first aid supplies? ',
  'Do you have the ability to get out of the house quickly?',
  'Do you have canned food and water?',
  'Do you have a whistle?',
  'Have you seen our educational section?'
];

final Map noanswer = {
  'Do you have first aid supplies? ': 'you should get first aid supplies',
  'Do you have the ability to get out of the house quickly?':
      'You should go to the place that you and your family have chosen.',
  'Do you have canned food and water?':
      'You should bring some canned food and water. ',
  'Do you have a whistle?': 'you should get whistle',
  'Have you seen our educational section?':
      'you should see our educational section, it\'s very important'
};
final Map yesanwer = {
  'Do you have first aid supplies? ':
      'Keep your first aid supplies close to the meeting place.',
  'Do you have the ability to get out of the house quickly?':
      'try to get out quickly from the house',
  'Do you have canned food and water?':
      ' Keep canned food and water close to your place',
  'Do you have a whistle?': 'keep the whistle with the food and water',
  'Have you seen our educational section?':
      'after seeing our education section ,Now you know alot.'
};

final List<String> valueQuestions = [
  'Where will the family meet if an earthquake occurs?',
  'Where are the important items?',
];

// Store answers
final Map<String, String> yesNoAnswers = {};
final Map<String, String> valueAnswers = {};

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quizplan(),
    );
  }
}

class Quizplan extends ConsumerStatefulWidget {
  const Quizplan({super.key});

  @override
  QuizplanState createState() => QuizplanState();
}

class QuizplanState extends ConsumerState<Quizplan> {
  // Define your questions
  List<String> useranswers = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool mode = ref.read(lightProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz'),
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : const Color.fromRGBO(0, 180, 216, 1),
      ),
      backgroundColor: mode
          ? Theme.of(context).colorScheme.primary
          : Color.fromRGBO(202, 240, 248, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Yes/No Questions
              ...yesNoQuestions.map((question) => ListTile(
                    title: Text(question),
                    trailing: DropdownButton<String>(
                      value: yesNoAnswers[question],
                      items: ['Yes', 'No'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          yesNoAnswers[question] = value!;
                          useranswers.add(value == 'Yes'
                              ? yesanwer[question]
                              : noanswer[question]);
                        });
                      },
                      hint: Text('Select'),
                    ),
                  )),

              SizedBox(height: 20),

              // Value Input Questions
              ...valueQuestions.map((question) => ListTile(
                    title: Text(question),
                    subtitle: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        valueAnswers[question] = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                  )),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.watch(planProvider.notifier).editplan(useranswers);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.secondaryFixed)),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
