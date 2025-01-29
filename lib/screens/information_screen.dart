import 'package:earthquake_protection/models/education.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          widget.title,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: 400,
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
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 20+size.toDouble()),
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
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.secondaryFixedDim)),
                    iconSize: 45,
                    color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.secondaryFixedDim),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.secondaryFixedDim)),
                    iconSize: 45,
                    color: Theme.of(context).colorScheme.primary,
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
                style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(300, 50))),
                child: Text(
                  languagenumber == 0 ? 'go to the quiz' : 'اذهب للإختبار',
                  style: TextStyle(fontSize: 25),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
