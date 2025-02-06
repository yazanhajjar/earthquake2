import 'package:earthquake_protection/earthquakelist.dart';
import 'package:earthquake_protection/education_screen.dart';
import 'package:earthquake_protection/mapscreen.dart';
import 'package:earthquake_protection/models/storage.dart';
import 'package:earthquake_protection/providers/auth.dart';
import 'package:earthquake_protection/providers/language.dart';
import 'package:earthquake_protection/providers/languagenumber.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/pagenumber.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:earthquake_protection/screens/apperplan.dart';
import 'package:earthquake_protection/screens/emergency.dart';
import 'package:earthquake_protection/screens/login.dart';
import 'package:earthquake_protection/screens/mesure_screen.dart';
import 'package:earthquake_protection/screens/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Widget activepage = const Listofearthquakes();

//use this function to select the right screen
  void activedpage(int currentpagenumber) {
    if (currentpagenumber == 0) {
      activepage = const Listofearthquakes();
    } else if (currentpagenumber == 1) {
      activepage = const Mapscreen();
    } else {
      activepage = const EducationScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    int languagenumber = ref.watch(languagenumberProvider);
    int currentpagenumber = ref.watch(pagenumberProvider);
    bool mode = ref.watch(lightProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : const Color.fromRGBO(0, 180, 216, 1),
        title: Title(
            color: Theme.of(context).colorScheme.primaryFixed,
            child: const Text(
              'Earthquake protection',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            )),
      ),
      backgroundColor:
          mode ? Theme.of(context).colorScheme.primary :  Color(0xf0f0f0f0),
      drawer: const MainDrawer(),
      body: ref.watch(pagenumberProvider) == 0
          ? const Listofearthquakes()
          : ref.watch(pagenumberProvider) == 1
              ? const Mapscreen()
              : const EducationScreen(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.surface,
        backgroundColor: mode
            ? Theme.of(context).colorScheme.secondaryFixedDim
            : Color.fromRGBO(0, 180, 216, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: currentpagenumber == 0 ? 35 : 25),
            label: languagenumber == 0 ? 'list' : 'القائمة',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on_outlined,
                size: currentpagenumber == 1 ? 35 : 25,
              ),
              label: languagenumber == 0 ? 'map' : 'الخريطة'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment,
                  size: currentpagenumber == 2 ? 35 : 25),
              label: languagenumber == 0 ? 'education' : 'التعليم')
        ],
        selectedLabelStyle: TextStyle(fontSize: 17),
        currentIndex: currentpagenumber,
        onTap: (value) {
          ref.read(pagenumberProvider.notifier).selectedpage(value);
        },
      ),
    );
  }
}

class MainDrawer extends ConsumerWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map thetext = ref.watch(languageProvider);
    int size = ref.watch(textsizeProvider);
    bool mode = ref.watch(lightProvider);
    return Drawer(
      backgroundColor: mode
          ? Theme.of(context).colorScheme.primaryFixedDim
          : Color(0xf0f0f0f0),
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: mode
                        ? [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(128)
                          ]
                        : [
                            Color.fromRGBO(0, 119, 182, 1),
                            Color.fromRGBO(4, 94, 211, 1)
                          ],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter)),
            child: const Row(
              children: [
                Icon(
                  Icons.signpost_rounded,
                  size: 40,
                ),
                Text(
                  'Earthquake protection',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(Icons.area_chart_rounded),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const MesureScreen()));
              },
              title: Text(
                thetext['mesure'],
                style: TextStyle(fontSize: 15 + size.toDouble()),
              )),
          ListTile(
              leading: const Icon(Icons.local_hospital_outlined),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const EmergencyScreen()));
              },
              title: Text(
                thetext['Emergency'],
                style: TextStyle(fontSize: 15 + size.toDouble()),
              )),
          ListTile(
              leading: const Icon(Icons.maps_ugc_rounded),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const Apperplan()));
              },
              title: Text(
                thetext['Plan'],
                style: TextStyle(fontSize: 15 + size.toDouble()),
              )),
          ListTile(
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const Settingscreen()));
              },
              title: Text(
                thetext['settings'],
                style: TextStyle(fontSize: 15 + size.toDouble()),
              )),
          ListTile(
              leading: const Icon(Icons.logout),
              onTap: () async {
                Navigator.pop(context);

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => const Login()));
                ref.watch(loginProvider.notifier).changingloginstate();

                await Storage.setvalue('login', false);
              },
              title: Text(
                thetext['languagenumber'] == '0' ? 'logout' : 'تسجيل الخروج',
                style: TextStyle(fontSize: 15 + size.toDouble()),
              )),
        ],
      ),
    );
  }
}
