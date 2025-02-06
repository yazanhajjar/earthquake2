import 'dart:convert';
import 'package:earthquake_protection/models/earthquakelist.dart';
import 'package:earthquake_protection/providers/language.dart';
import 'package:earthquake_protection/providers/light.dart';
import 'package:earthquake_protection/providers/markers.dart';
import 'package:earthquake_protection/providers/pagenumber.dart';
import 'package:earthquake_protection/providers/textsize.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Listofearthquakes extends ConsumerStatefulWidget {
  const Listofearthquakes({super.key});

  @override
  ConsumerState<Listofearthquakes> createState() => _ListofearthquakesState();
}

class _ListofearthquakesState extends ConsumerState<Listofearthquakes>
    with SingleTickerProviderStateMixin {
  int filterforce = 1;
  DateTime filtertime = DateTime.utc(2000);
  late TabController _tabController;

  var url =
      Uri.https('osama-un0e.onrender.com', 'api/sensor-data');
  List<dynamic> loadedData = [];

  loadinglist() async {
    http.Response respone = await http.get(
      url,
    );
    loadedData = json.decode(respone.body);

    setState(() {
      for (final item in loadedData) {
        earthquakeList.add(Earthquake(
            time: DateTime.parse(item['time_happend']),
            force: item['intensity'].toDouble(),
            location: item['location'].toString()=='Unknown Location'?'syria_homs':item['location'].toString(),
            latLng: const LatLng(35.69059124387986, 37.66976991898514)));
      }
    });
  }


  @override
  void initState() {
    loadinglist();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: filtertime,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null && picked != filtertime) {
      setState(() {
        filtertime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map thetext = ref.watch(languageProvider);
    int size = ref.watch(textsizeProvider);
    bool mode=ref.watch(lightProvider);

    final List<Tab> ourtabs = [
      const Tab(
        text: 'ALL',
      ),
      const Tab(
        text: 'Force',
      ),
      const Tab(
        text: 'Date',
      ),
    ];
    final List<Tab> ourtabsarbic = [
      const Tab(
        text: 'الكل',
      ),
      const Tab(
        text: 'الشدة',
      ),
      const Tab(
        text: 'التاريخ',
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          labelColor: Theme.of(context).colorScheme.onPrimary,
          tabs: thetext['languagenumber'] == '0' ? ourtabs : ourtabsarbic,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 15 + size.toDouble()),
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            Tabwidget(
              myearthquakes: earthquakeList,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          thetext['Select the force :'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16 + size.toDouble()),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 35,
                          width: 100,
                          child: DropdownButton(
                              focusColor:
                                  Theme.of(context).colorScheme.secondary,
                              dropdownColor:mode?
                                  Theme.of(context).colorScheme.onPrimaryFixed:Color(0xf0f0f0f0),
                              borderRadius: BorderRadius.circular(10),
                              hint: Text('$filterforce+',
                                  textAlign: TextAlign.center),
                              // disabledHint: Text('$filterforce'),
                              // value: filterforce,
                              items: const [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text(
                                    '1+',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child:
                                      Text('2+', textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child:
                                      Text('3+', textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 4,
                                  child:
                                      Text('4+', textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 5,
                                  child:
                                      Text('5+', textAlign: TextAlign.center),
                                ),
                                DropdownMenuItem(
                                  value: 6,
                                  child:
                                      Text('6+', textAlign: TextAlign.center),
                                ),
                              ],
                              onChanged: (newval) {
                                setState(() {
                                  if (newval == null) {
                                    return;
                                  } else {
                                    filterforce = newval;
                                  }
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Tabwidget(
                    myearthquakes: earthquakeList
                        .where((e) => e.force > filterforce)
                        .toList(),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _selectYear(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimaryFixed),
                          child: Text(
                            thetext['Select Year'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ),
                      Text(
                        "${thetext['Selected Year:']} ${filtertime.year}",
                        style: TextStyle(
                            fontSize: 20 + size.toDouble(),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Tabwidget(
                    myearthquakes: earthquakeList
                        .where((e) => e.time.year >= filtertime.year)
                        .toList(),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

class Tabwidget extends ConsumerWidget {
  const Tabwidget({
    super.key,
    required this.myearthquakes,
  });

  final List<Earthquake> myearthquakes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool mode = ref.watch(lightProvider);
    return SingleChildScrollView(
      child: Column(children: [
        ...myearthquakes.map((e) => InkWell(
              onTap: () {
                ref.read(pagenumberProvider.notifier).selectedpage(1);
                ref.read(markersProvider.notifier).addMarker(
                      Marker(
                        markerId: const MarkerId('earthquake location'),
                        position: e.latLng,
                        infoWindow:
                            const InfoWindow(title: 'earthquake Location'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed),
                      ),
                    );
              },
              child: Card(
                color: mode?Theme.of(context).colorScheme.secondaryFixedDim:Color.fromRGBO(0, 119, 182 ,1),
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(10),
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                          color: e.force < 3.5
                              ? const Color.fromARGB(255, 166, 178, 167)
                              : Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        e.force.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Row(children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e.time.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e.location,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      )
                    ])
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
