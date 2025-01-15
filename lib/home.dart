import 'package:earthquake_protection/earthquakelist.dart';
import 'package:earthquake_protection/education_screen.dart';
import 'package:earthquake_protection/mapscreen.dart';
import 'package:earthquake_protection/providers/pagenumber.dart';
import 'package:earthquake_protection/screens/emergency.dart';
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
    int currentpagenumber = ref.watch(pagenumberProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
        title: Title(
            color: Theme.of(context).colorScheme.primaryFixed,
            child: const Text(
              'Earthquake protection',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            )),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: const MainDrawer(),
      body: ref.watch(pagenumberProvider) == 0
          ? const Listofearthquakes()
          : ref.watch(pagenumberProvider) == 1
              ? const Mapscreen()
              : const EducationScreen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: currentpagenumber == 0 ? 35 : 25),
            label: 'list',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on_outlined,
                size: currentpagenumber == 1 ? 35 : 25,
              ),
              label: 'map'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment,
                  size: currentpagenumber == 2 ? 35 : 25),
              label: 'education')
        ],
        currentIndex: currentpagenumber,
        onTap: (value) {
          ref.read(pagenumberProvider.notifier).selectedpage(value);
        },
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondary.withAlpha(128)
            ], end: Alignment.topCenter, begin: Alignment.bottomCenter)),
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
              title: const Text('mesure')),
          ListTile(
              leading: const Icon(Icons.local_hospital_outlined),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const EmergencyScreen()));
              },
              title: const Text('Emergency')),
          ListTile(
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const Settingscreen()));
              },
              title: const Text('settings')),
        ],
      ),
    );
  }
}