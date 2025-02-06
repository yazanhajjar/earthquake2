import 'dart:async';
import 'dart:math';

import 'package:earthquake_protection/providers/language.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_plus/sensors_plus.dart';

class MesureScreen extends ConsumerStatefulWidget {
  const MesureScreen({super.key});

  @override
  ConsumerState<MesureScreen> createState() => _MesureScreenState();
}

class _MesureScreenState extends ConsumerState<MesureScreen> {
  static const maxvalue = 30;
  int second = maxvalue;
  Timer? timer;
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double force = 0;
  double maxforce = 0;
  int counter = 0;
  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  void _startTimer() {
    maxforce = 0;
    counter++;
    resetTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          stoptimer(reset: false);
        }
      });
    });
  }

  resetTimer() => setState(() {
        second = maxvalue;
      });

  stoptimer({reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer?.cancel();
  }

  get isrunning {
    bool running = timer == null ? false : timer!.isActive;
    return running;
  }

  double get ourforce {
    setState(() {
      double a = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
      force = 2.6 * a;
      if (maxforce < force && force < 9) {
        maxforce = force;
      }
    });
    return force;
  }

  @override
  void initState() {
    super.initState();
    counter = 0;
    maxforce = 0;
    _gyroscopeSubscription =
        gyroscopeEventStream(samplingPeriod: Durations.short4)
            .listen((GyroscopeEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose(); //اتذكر جرب الكود بعد هادا التعديل
  }

  @override
  Widget build(BuildContext context) {
    Map thetext = ref.read(languageProvider);
    int size = ref.read(textsizeProvider);
    bool mode = ref.watch(lightProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          thetext['Earthquake mesuring'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
        ),
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : const Color.fromRGBO(0, 180, 216, 1),
      ),
      backgroundColor:
          mode ? Theme.of(context).colorScheme.primary :  Color.fromRGBO(202, 240, 248,1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                thetext['mesurephrase'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20 + size.toDouble(),
                    color: Theme.of(context).colorScheme.scrim),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: second / maxvalue,
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).colorScheme.scrim),
                      color: Colors.white,
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      strokeWidth: 12,
                    ),
                    Center(
                        child: isrunning
                            ? Text(
                                second.toString(),
                                style: const TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            : Icon(
                                Icons.done,
                                color: Theme.of(context).colorScheme.scrim,
                                size: 100,
                              )),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            isrunning
                ? ElevatedButton(
                    onPressed: stoptimer,
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(mode
                            ? Theme.of(context).colorScheme.secondaryFixedDim
                            : const Color.fromRGBO(0, 180, 216, 1))),
                    child: Text(
                      thetext['End mesuring'],
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryFixed,
                          fontWeight: FontWeight.bold,
                          fontSize: 20 + size.toDouble()),
                    ),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(mode
                            ? Theme.of(context).colorScheme.secondaryFixedDim
                            : const Color.fromRGBO(0, 180, 216, 1))),
                    onPressed: _startTimer,
                    child: Text(thetext['Start mesuring'],
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSecondaryFixed,
                            fontWeight: FontWeight.bold,
                            fontSize: 20 + size.toDouble()))),
            const SizedBox(
              height: 15,
            ),
            if (counter > 0 && isrunning)
              Column(
                children: [
                  Text(
                    'X: ${x.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text('Y: ${y.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Text('Z: ${z.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  Text('Force: ${ourforce.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)
                ],
              ),
            if (!isrunning && counter != 0)
              Text(
                thetext['languagenumber'] == '1'
                    ? '''
شدة الزلزال
     ${maxforce.toStringAsFixed(2)}
'''
                    : '''The Forse of earthquake
                 ${maxforce.toStringAsFixed(2)}''',
                style: TextStyle(
                  fontSize: 20 + size.toDouble(),
                  fontWeight: FontWeight.bold,
                ),
              )
          ],
        ),
      ),
    );
  }
}
