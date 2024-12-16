import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'common/colors.dart';

class RmsHome extends StatefulWidget {
  @override
  _RmsHomeState createState() => _RmsHomeState();
}

class _RmsHomeState extends State<RmsHome> {
  late List<ChartData> chartData;
  late List<ChartDataMineral> mChartData;
  late TooltipBehavior tooltip;
  int? explodedIndex;

  @override
  void initState() {
    super.initState();
    tooltip = TooltipBehavior(enable: true);
    chartData = [
      ChartData('Rift African Gems Limited', 1500),
      ChartData('Quanta Africa Gems', 800),
      ChartData('Abisal Global Limited', 1200),
      ChartData('Crown Marble & Quartz', 600),
      ChartData('QUSSAN Enterprises', 900),
      ChartData('Monpro Engineering Services', 1400),
      ChartData('Aquamarine Dealers Ltd', 500),
      ChartData('Mara Mining Ltd', 700),
      ChartData('East African Pure Gold Ltd', 1100),
      ChartData('Kenya Gems & Minerals Ltd', 600),
    ];
    mChartData = [
      ChartDataMineral('Rough diamonds', 1500),
      ChartDataMineral('Fluorspar', 800),
      ChartDataMineral('Soda ash', 1200),
      ChartDataMineral('Gypsum', 600),
      ChartDataMineral('Limestone', 900),
      ChartDataMineral('Coal', 1400),
      ChartDataMineral('Titanium ores', 500),
      ChartDataMineral('Copper', 700),
      ChartDataMineral('Rare earth elements', 1100),
      ChartDataMineral('Gold', 600),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorPrimary1, colorPrimary2],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'RMS Home',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        GestureDetector(
                          child: Image.asset('asset/images/logout_logo.png', height: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 24, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome', style: TextStyle(color: homeText, fontSize: 18)),
                        Text('Mr. Nelson Odhiamba', style: TextStyle(color: Colors.white, fontSize: 18)),
                        Text('Mining Inspector, Mombasa Regional Office', style: TextStyle(color: homeText2, fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '   Inspection Details',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                const SizedBox(width: 5),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Request', style: TextStyle(fontSize: 16)),
                                    Text('9824', style: TextStyle(fontSize: 18, color: columnBarColor)),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Image.asset('asset/images/right_arrow.png', height: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                const SizedBox(width: 5),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Pending', style: TextStyle(fontSize: 16)),
                                    Text('8273', style: TextStyle(fontSize: 20, color: textColor2)),
                                  ],
                                ),
                                const SizedBox(width: 24),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Image.asset('asset/images/right_arrow.png', height: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                const SizedBox(width: 5),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Completed', style: TextStyle(fontSize: 16)),
                                    Text('873', style: TextStyle(fontSize: 18, color: Colors.green)),
                                  ],
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Image.asset('asset/images/right_arrow.png', height: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                const SizedBox(width: 2),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Qty Validate', style: TextStyle(fontSize: 16)),
                                    Text('1,21,234', style: TextStyle(fontSize: 18, color: textColor2)),
                                  ],
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: Image.asset('asset/images/right_arrow.png', height: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: homeText2,
                              child: Image.asset(
                                'asset/images/cooperation.png',
                                color: Colors.orange,
                                height: 25,
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Inspection Draft Data',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '234',
                                  style: TextStyle(fontSize: 18, color: textColor2),
                                ),
                              ],
                            ),
                            Image.asset('asset/images/right_arrow.png', height: 20)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Miner wise Inspection requests',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                Icon(Icons.menu)
                              ],
                            ),
                            Divider(color: Colors.grey.withOpacity(0.2),),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  labelRotation: -45,
                                  autoScrollingDelta: 12,
                                  interval: 1,
                                  autoScrollingMode: AutoScrollingMode.start,
                                  labelPlacement: LabelPlacement.betweenTicks, // Places labels between ticks
                                  majorGridLines: MajorGridLines(width: 0),
                                  labelStyle: TextStyle(fontSize: 11)
                                ),
                                primaryYAxis: NumericAxis(
                                  maximum: 1500,
                                  autoScrollingMode: AutoScrollingMode.start,
                                  majorGridLines: MajorGridLines(width: 0), // Optional: hide grid lines
                                ),
                                tooltipBehavior: tooltip,
                                series: <ChartSeries>[
                                  ColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x, // X values
                                    yValueMapper: (ChartData data, _) => data.y, // Y values
                                    name: 'Payment',
                                    color: columnBarColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    width: 0.5, // Adjust width to align with labels
                                    spacing: 0.2, // Adjust spacing to fit better
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Miner wise Pending Inspection requests',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                Icon(Icons.menu)
                              ],
                            ),
                            Divider(color: Colors.grey.withOpacity(0.2),),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelRotation: -45,
                                    autoScrollingDelta: 12,
                                    interval: 1,
                                    autoScrollingMode: AutoScrollingMode.start,
                                    labelPlacement: LabelPlacement.betweenTicks, // Places labels between ticks
                                    majorGridLines: MajorGridLines(width: 0),
                                    labelStyle: TextStyle(fontSize: 11)
                                ),
                                primaryYAxis: NumericAxis(
                                  maximum: 1500,
                                  autoScrollingMode: AutoScrollingMode.start,
                                  majorGridLines: MajorGridLines(width: 0), // Optional: hide grid lines
                                ),
                                tooltipBehavior: tooltip,
                                series: <ChartSeries>[
                                  ColumnSeries<ChartData, String>(
                                    dataSource: chartData,
                                    xValueMapper: (ChartData data, _) => data.x, // X values
                                    yValueMapper: (ChartData data, _) => data.y, // Y values
                                    name: 'Payment',
                                    color: columnBarColor2,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    width: 0.5, // Adjust width to align with labels
                                    spacing: 0.2, // Adjust spacing to fit better
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Month wise Inspection request',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                Icon(Icons.menu)
                              ],
                            ),
                            Divider(color: Colors.grey.withOpacity(0.2),),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SfCircularChart(
                                margin: EdgeInsets.zero,
                                legend:  Legend(isVisible: false),
                                series: <PieSeries<_PieData, String>>[
                                  PieSeries<_PieData, String>(
                                    explode: true,
                                    explodeIndex: explodedIndex,
                                    onPointTap: (ChartPointDetails details) {
                                      setState(() {
                                        if (explodedIndex == details.pointIndex) {
                                          explodedIndex = null; // Collapse the currently exploded segment
                                        } else {
                                          explodedIndex = details.pointIndex; // Explode the new segment
                                        }
                                      });
                                    },
                                    dataSource: pieRingData,
                                    xValueMapper: (_PieData data, _) => data.xData,
                                    yValueMapper: (_PieData data, _) => data.yData,
                                    dataLabelMapper: (_PieData data, _) => data.text,
                                    // startAngle: 90,
                                    // endAngle: 90,
                                    dataLabelSettings: const DataLabelSettings(isVisible: true, // Make the data label visible
                                      labelPosition: ChartDataLabelPosition.inside, // Position inside the segment
                                    ),
                                    pointColorMapper: (_PieData data, _) => data.color,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Miner wise Pending Inspection requests',
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                                Icon(Icons.menu)
                              ],
                            ),
                            Divider(color: Colors.grey.withOpacity(0.2),),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                    labelRotation: -45,
                                    autoScrollingDelta: 12,
                                    interval: 1,
                                    autoScrollingMode: AutoScrollingMode.start,
                                    labelPlacement: LabelPlacement.betweenTicks, // Places labels between ticks
                                    majorGridLines: MajorGridLines(width: 0),
                                    labelStyle: TextStyle(fontSize: 11)
                                ),
                                primaryYAxis: NumericAxis(
                                  maximum: 1500,
                                  autoScrollingMode: AutoScrollingMode.start,
                                  majorGridLines: MajorGridLines(width: 0), // Optional: hide grid lines
                                ),
                                tooltipBehavior: tooltip,
                                series: <ChartSeries>[
                                  ColumnSeries<ChartDataMineral, String>(
                                    dataSource: mChartData,
                                    xValueMapper: (ChartDataMineral data, _) => data.x, // X values
                                    yValueMapper: (ChartDataMineral data, _) => data.y, // Y values
                                    name: 'Payment',
                                    color: syncSalesColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    width: 0.5, // Adjust width to align with labels
                                    spacing: 0.2, // Adjust spacing to fit better
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class ChartDataMineral {
  ChartDataMineral(this.x, this.y);
  final String x;
  final double y;
}

class _PieData {
  _PieData(this.xData, this.yData, this.text, this.color);

  final String xData;
  final double yData;
  final String text;
  final Color color;
}

// Dummy data source for the pie chart
final List<_PieData> pieRingData = [
  _PieData('January', 10, '10%', Color(0xFFE78A2A)),
  _PieData('February', 15, '15%', Color(0xFF333333)),
  _PieData('March', 20, '20%', Color(0xFF2765D2)),
  _PieData('April', 25, '25%', Color(0xFF835CC8)),
  _PieData('May', 30, '30%', Color(0xFFFFBB00)),
  _PieData('June', 35, '35%', Color(0xFFCF1C19)),
  _PieData('July', 40, '40%', Color(0xFF4ABFB0)),
  _PieData('August', 45, '45%', Color(0xFF7A6760)),
  _PieData('September', 50, '50%', Color(0xFF4DCC9C)),
  _PieData('October', 55, '55%', Color(0xFFE67761)),
  _PieData('November', 60, '60%', Color(0xFF80A4FB)),
  _PieData('December', 65, '65%', Color(0xFF909DAA)),
];

