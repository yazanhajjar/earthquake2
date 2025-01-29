import 'package:earthquake_protection/providers/language.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:earthquake_protection/screens/earthquake_education.dart';
import 'package:earthquake_protection/screens/earthquakequiz.dart';
import 'package:earthquake_protection/screens/fire_education.dart';
import 'package:earthquake_protection/screens/firequiz.dart';
import 'package:earthquake_protection/screens/medicaleducation.dart';
import 'package:earthquake_protection/screens/medicalquiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EducationScreen extends ConsumerWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref)  {
    Map thetext=ref.watch(languageProvider);
    return Container(
      margin: const EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2.5 / 2),
        children:  [
          MyContainer(
            title: thetext['Earthquake Prevention'],
            screen: EarthquakeEducation(),
          ),
          MyContainer(
              title: thetext['Earthquake Prevention quiz'], screen: Earthquakequiz()),
          MyContainer(title: thetext['Fire prevention'], screen: FireEducation()),
          MyContainer(title: thetext['Fire prevention quiz'], screen: Firequiz()),
          MyContainer(title: thetext['First aid'], screen: Medicaleducation()),
          MyContainer(title: thetext['First aid quiz'], screen: Medicalquiz())
        ],
      ),
    );
  }
}

class MyContainer extends ConsumerWidget {
  const MyContainer({super.key, required this.title, required this.screen});
  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
        int size=ref.watch(textsizeProvider);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => screen));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withValues(alpha: 0.5),
        ),
        margin: const EdgeInsets.all(4),
        child: Center(
          child: Text(
            title,
            style:  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18+size.toDouble(),
            ),textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
