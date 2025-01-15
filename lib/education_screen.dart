import 'package:earthquake_protection/screens/earthquake_education.dart';
import 'package:earthquake_protection/screens/earthquakequiz.dart';
import 'package:earthquake_protection/screens/fire_education.dart';
import 'package:earthquake_protection/screens/firequiz.dart';
import 'package:earthquake_protection/screens/medicaleducation.dart';
import 'package:earthquake_protection/screens/medicalquiz.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(1, 10, 1, 10),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2.5 / 2),
        children: const [
          MyContainer(
            title: 'Earthquake Prevention',
            screen: EarthquakeEducation(),
          ),
          MyContainer(
              title: 'Earthquake Prevention quiz', screen: Earthquakequiz()),
          MyContainer(title: 'Fire prevention', screen: FireEducation()),
          MyContainer(title: 'Fire prevention quiz', screen: Firequiz()),
          MyContainer(title: 'First aid', screen: Medicaleducation()),
          MyContainer(title: 'First aid quiz', screen: Medicalquiz())
        ],
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key, required this.title, required this.screen});
  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
