import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rootally_ai/screens/results.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final dref = FirebaseDatabase.instance.ref();
  late DatabaseReference _databaseReference;
  int selectedIndex = 0;
  List<IconData> data = [
    Icons.home_rounded,
    FontAwesomeIcons.wheelchair,
    FontAwesomeIcons.compass,
    FontAwesomeIcons.user,
  ];

  @override
  void initState() {
    _databaseReference = dref;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _customBottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _customFloatingActionButton(),
      body: Container(
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: ListView(children: [
          // good morning text
          const Text(
            'Good Morning\nJane',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 20),
          // Today's Progress Card
          _todaysProgressCard(context),
          // Main timeline
          FirebaseAnimatedList(
            shrinkWrap: true,
            query: _databaseReference,
            itemBuilder: (context, snapshot, animation, index) {
              var trial = snapshot.value as Map;
              List<DataModel> _list = [];
              trial.forEach((key, value) {
                _list.add(
                  DataModel(
                    performedAt: value['performedAt'],
                    program: value['program'],
                    title: value['title'],
                    isCompleted: value['isCompleted'],
                  ),
                );
              });
              _list = _list.reversed.toList();
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Timeline.builder(
                    position: TimelinePosition.Left,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) => TimelineModel(
                          Stack(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _list[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          if (_list[index].isCompleted)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blue[900],
                                              ),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 5,
                                                    left: 10,
                                                    right: 10),
                                                child: const Text(
                                                  'Completed',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          if (_list[index].isCompleted)
                                            const Text(
                                              'Performed At',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          if (_list[index].isCompleted)
                                            Text(
                                              _list[index].performedAt,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                // color: Colors.blue,
                                              ),
                                            ),
                                          if (index == 1)
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.yellow[700],
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 10,
                                                            right: 10),
                                                    child: const Text(
                                                      'Performed',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                const Text(
                                                  'Enter Pain Score',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.blue[900],
                                                      ),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .all(3),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons
                                                                .restart_alt_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.grey[350],
                                                      ),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 10,
                                                            right: 10),
                                                        child: const Text(
                                                          'Retry',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          if (index != 1 && index != 0)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.blue[900],
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(3),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey[350],
                                                  ),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 10,
                                                            right: 10),
                                                    child: const Text(
                                                      'Start',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: Container(
                                        height: 110,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.red,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/session${index + 1}.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            )),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              if (index == 1)
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              if (_list[index].isCompleted)
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                    height: 124,
                                    width: double.infinity,
                                  ),
                                ),
                            ],
                          ),
                          icon: Icon(
                            index < 2
                                ? Icons.check
                                : Icons.blur_circular_rounded,
                            color: Colors.white,
                          ),
                          position: TimelineItemPosition.right,
                          iconBackground:
                              index < 2 ? Colors.blue.shade900 : Colors.grey,
                        ),
                    itemCount: _list.length),
              );
            },
          )
        ]),
      ),
    );
  }

  Padding _customBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Material(
        // elevation: 10,
        // borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = i;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 35,
                    decoration: BoxDecoration(
                      border: i == selectedIndex
                          ? const Border(
                              top: BorderSide(width: 4.0, color: Colors.black))
                          : null,
                    ),
                    child: Icon(
                      data[i],
                      size: 35,
                      color: i == selectedIndex
                          ? Colors.black
                          : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _customFloatingActionButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.blue[900],
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Results(),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      label: Row(
        children: const [
          Icon(
            Icons.play_arrow_rounded,
            size: 35,
          ),
          SizedBox(width: 5),
          Text(
            'Start Session',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Card _todaysProgressCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Progress',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '50%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]!,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[400],
                  ),
                ),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_box_rounded,
                      color: Colors.green,
                      size: 50,
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'Completed',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: '\n2 Sessions',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900]!,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 3),
                    RichText(
                      text: const TextSpan(
                        text: 'Completed',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: '\n2 Sessions',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DataModel {
  final String performedAt;
  final String program;
  final String title;
  final bool isCompleted;
  DataModel({
    required this.performedAt,
    required this.program,
    required this.title,
    required this.isCompleted,
  });
}
