import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InformationScreen extends ConsumerStatefulWidget {
  const InformationScreen(
      {super.key,
      required this.title,
      required this.information,
      required this.screen});
  final String title;
  final List<InformationList> information;
  final Widget screen;
  @override
  ConsumerState<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends ConsumerState<InformationScreen> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    int languagenumber = ref.read(languagenumberProvider);
    int size = ref.read(textsizeProvider);
    bool mode = ref.read(lightProvider);
    return Scaffold(
      backgroundColor: mode
          ? Theme.of(context).colorScheme.primary
          : Color.fromRGBO(202, 240, 248, 1),
      appBar: AppBar(
        title: Text(
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          widget.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : const Color.fromRGBO(0, 180, 216, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          fit: BoxFit.contain,
                          widget.information[number].image,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.information[number].text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mode
                                ? Theme.of(context).colorScheme.onSecondary
                                : Colors.black,
                            fontSize: 20 + size.toDouble()),
                      )
                    ],
                  ),
                )),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(mode
                            ? Theme.of(context).colorScheme.secondaryFixedDim
                            : const Color.fromRGBO(0, 180, 216, 1))),
                    iconSize: 45,
                    color: mode
                        ? Theme.of(context).colorScheme.primary
                        : Color.fromRGBO(202, 240, 248, 1),
                    onPressed: () {
                      if (number > 0) {
                        setState(() {
                          number--;
                        });
                      } else {
                        return;
                      }
                    },
                    icon: const Icon(Icons.arrow_left),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    '${number + 1} __ ${widget.information.length}',
                    style: TextStyle(
                        fontSize: 40,
                        color: mode
                            ? Theme.of(context).colorScheme.secondaryFixedDim
                            : Colors.black),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(mode
                            ? Theme.of(context).colorScheme.secondaryFixedDim
                            : const Color.fromRGBO(0, 180, 216, 1))),
                    iconSize: 45,
                    color: mode
                        ? Theme.of(context).colorScheme.primary
                        : Color.fromRGBO(202, 240, 248, 1),
                    onPressed: () {
                      if (number < widget.information.length - 1) {
                        setState(() {
                          number++;
                        });
                      } else {
                        return;
                      }
                    },
                    icon: const Icon(Icons.arrow_right),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (number == widget.information.length - 1)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => widget.screen));
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(mode
                        ? Theme.of(context).colorScheme.secondaryFixedDim
                        : Color.fromRGBO(0, 180, 216, 1)),
                    fixedSize: WidgetStatePropertyAll(Size(300, 50))),
                child: Text(
                  languagenumber == 0 ? 'go to the quiz' : 'اذهب للإختبار',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:mode?Colors.white: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
