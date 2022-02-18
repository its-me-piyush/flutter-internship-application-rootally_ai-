import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  late List<ChartData> chartData;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    chartData = [
      ChartData(
        'Set 1',
        10,
        4,
      ),
      ChartData(
        'Set 3',
        10,
        5,
      ),
      ChartData(
        'Set 4',
        7,
        5,
      ),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          _resultTopHeading(),
          const SizedBox(height: 20),
          _customAccuracyIndicator(),
          const SizedBox(height: 20),
          _customTopTwoButtons(),
          const SizedBox(height: 5),
          _customSetDetails(),
          const SizedBox(height: 20),
          _customFirstCard(),
          const SizedBox(height: 5),
          const CustomResultsCard(
            title: 'Knee Bend',
            color: Color(0xFFFE6365),
          ),
          const SizedBox(height: 5),
          const CustomResultsCard(
              title: 'Hamstring Strech', color: Color(0XFF255ED7)),
        ],
      ),
    );
  }

  Container _customFirstCard() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leg Raise',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: Row(
                      children: const [
                        Text(
                          'Sets',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          backgroundColor: Color(0xFF55CEC0),
                          maxRadius: 12,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          backgroundColor: Color(0xFFF5C30E),
                          maxRadius: 12,
                          child: Icon(
                            Icons.fast_forward_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.cancel,
                          color: Color(0xFFFE6362),
                          size: 25,
                        ),
                        SizedBox(width: 15),
                        Icon(
                          Icons.arrow_drop_up_rounded,
                          color: Colors.black,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // chart todo
              SizedBox(
                height: 150,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                        color: Color(0xFF55CFC1),
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                    ColumnSeries<ChartData, String>(
                        color: Color(0xFFFF6262),
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y2),
                  ],
                ),
              ),

              const Text(
                'Range of Motion',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.grey,
                    ),
                    _customRangeOfMotionItemDisplay('Set 1'),
                    const SizedBox(width: 5),
                    _customRangeOfMotionItemDisplay('Set 3'),
                    const SizedBox(width: 5),
                    _customRangeOfMotionItemDisplay('Set 4'),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _customRangeOfMotionItemDisplay(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const CustomCardRichText(title: 'Min', value: 64),
          const CustomCardRichText(title: 'Max', value: 64),
          const CustomCardRichText(title: 'Avg', value: 64),
        ],
      ),
    );
  }

  Container _customSetDetails() {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Set Details',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Color(0xFF55CEC0),
                    maxRadius: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Completed',
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Color(0xFFF5C30E),
                    maxRadius: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Skipped',
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Color(0xFFFE6362),
                    maxRadius: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Incomplete',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _customTopTwoButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[350],
          ),
          child: Container(
            margin:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: Row(
              children: [
                Icon(
                  Icons.play_circle_fill_rounded,
                  color: Colors.blue[900],
                  size: 25,
                ),
                const SizedBox(width: 5),
                const Text(
                  'Play Video',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[900],
          ),
          child: Container(
            margin:
                const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
            child: Row(
              children: const [
                Icon(
                  Icons.share_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(width: 5),
                Text(
                  'Analytics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Center _customAccuracyIndicator() {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              color: Colors.blue[900],
              strokeWidth: 5,
              value: 0.65,
            ),
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Accuracy',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '64%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Column _resultTopHeading() {
    return Column(
      children: [
        const Center(
          child: Text(
            'You did amazing!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Session 1 Complete',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Icon(
              Icons.check_circle_rounded,
              size: 30,
              color: Colors.blue[900],
            ),
          ],
        ),
      ],
    );
  }
}

class CustomResultsCard extends StatelessWidget {
  const CustomResultsCard({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: 8,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Row(
              children: const [
                Text(
                  'Sets',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Color(0xFF55CEC0),
                  maxRadius: 12,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Color(0xFFF5C30E),
                  maxRadius: 12,
                  child: Icon(
                    Icons.fast_forward_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.cancel,
                  color: Color(0xFFFE6362),
                  size: 25,
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.black,
                  size: 25,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class CustomCardRichText extends StatelessWidget {
  const CustomCardRichText({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title ',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: '\t \t \t \t $value°',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final String x;
  final double? y;
  final double? y2;
}
