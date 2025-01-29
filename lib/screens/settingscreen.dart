import 'package:earthquake_protection/providers/language.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settingscreen extends ConsumerWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int languagenumber = ref.watch(languagenumberProvider);
    int size = ref.watch(textsizeProvider);
    Set<int> selectedValue = {languagenumber};
    Set<int> selectedsize = {size};
    bool light = ref.watch(lightProvider);
    int force = 1;



Widget mytitle(BuildContext context, String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20+size.toDouble()),
    ),
  );
}


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
        title: Text(languagenumber == 0 ? 'Settings' : 'الإعدادات',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ListView(padding: const EdgeInsets.all(16), children: [
        mytitle(context, languagenumber == 0 ? 'language' : 'اللغة'),
        SegmentedButton(
          segments: [
            ButtonSegment(
                value: 0,
                label: Text('English',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15+size.toDouble()))),
            ButtonSegment(
                value: 1,
                label: Text(
                  'عربي',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15+size.toDouble()),
                ))
          ],
          selected: selectedValue,
          multiSelectionEnabled: false,
          onSelectionChanged: (newval) {
            if (newval.contains(1)) {
              ref.read(languageProvider.notifier).changeLanguage('arabic');
              ref.read(languagenumberProvider.notifier).changinglanguage();
            } else if (newval.contains(0)) {
              ref.read(languageProvider.notifier).changeLanguage('english');
              ref.read(languagenumberProvider.notifier).changinglanguage();
            }
            selectedValue = newval;
          },
        ),
        Divider(),
        mytitle(context, languagenumber == 0 ? 'Theme' : 'الوضع'),
        ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text(
            languagenumber == 0 ? ' Dark Mode' : 'الوضع الليلي',
            style: TextStyle(fontSize: 15+size.toDouble(), fontWeight: FontWeight.bold),
          ),
          trailing: Switch(
            activeTrackColor: Colors.green,
            inactiveThumbColor: Theme.of(context).colorScheme.error,
            inactiveTrackColor: Colors.grey,
            value: light,
            onChanged: (value) {
              light = value;
              ref.read(lightProvider.notifier).changingMode();
            },
          ),
        ),
        Divider(),
        mytitle(
            context, languagenumber == 0 ? 'force of alert' : 'شدة التنبيه'),
        ListTile(
          leading: Icon(Icons.notification_add_outlined),
          title: Text(
            languagenumber == 0
                ? 'Select a value to alert at :'
                : 'اختر قيمة للتنبه عندها ',
            style: TextStyle(fontSize: 15+size.toDouble(), fontWeight: FontWeight.bold),
          ),
          trailing: SizedBox(
            height: 35,
            width: 50,
            child: DropdownButton(
                focusColor: Theme.of(context).colorScheme.secondaryFixedDim,
                dropdownColor: Theme.of(context).colorScheme.secondaryFixedDim,
                borderRadius: BorderRadius.circular(5),
                hint: Text('$force', textAlign: TextAlign.center),
                value: force,
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text(
                      '1',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('2+', textAlign: TextAlign.center),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text('3+', textAlign: TextAlign.center),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text('4+', textAlign: TextAlign.center),
                  ),
                  DropdownMenuItem(
                    value: 5,
                    child: Text('5+', textAlign: TextAlign.center),
                  ),
                  DropdownMenuItem(
                    value: 6,
                    child: Text('6+', textAlign: TextAlign.center),
                  ),
                ],
                onChanged: (newval) {
                  if (newval == null) {
                    return;
                  } else {
                    force = newval;
                  }
                }),
          ),
        ),
        Divider(),
        mytitle(context,
            languagenumber == 0 ? 'Changing Text Size' : 'تغيير حجم الخط'),
        Row(
          children: [
            Icon(Icons.format_size_rounded),
            Text(
              languagenumber == 0 ? ' Select Text Size' : 'اختر حجم الخط',
              style: TextStyle(fontSize: 15+size.toDouble(), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SegmentedButton(
          segments: [
            ButtonSegment(
                value: -3,
                label: Text(languagenumber == 0 ?'small':'صغير',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15+size.toDouble()))),
            ButtonSegment(
                value: 0,
                label: Text(
                  languagenumber == 0 ?'medium':'متوسط',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15+size.toDouble()),
                )),
            ButtonSegment(
                value: 3,
                label: Text(
                languagenumber == 0 ?  'large':'كبير',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15+size.toDouble()),
                ))
          ],
          selected: selectedsize,
          multiSelectionEnabled: false,
          onSelectionChanged: (newval) {
            ref.watch(textsizeProvider.notifier).changingvalue(newval.first);
          },
        ),
      ]),
    );
  }
}

