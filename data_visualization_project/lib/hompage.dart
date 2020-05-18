import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bubble_chart/bubble_chart.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<DisabilityTypeBubbleChart, String>> _seriesBubbleData;
  List<charts.Series<DisabilityPie, String>> _seriesPieData;
  List<charts.Series<DisabilityLineChart, int>> _seriesLineData;

  final root = BubbleNode.node(
    padding: 15,
    children: [
      BubbleNode.node(
        padding: 30,
        children: [
          BubbleNode.leaf(
            options: BubbleOptions(
              child: Text('PAs'),
              color: Colors.blue,
            ),
            value: 2583,
          ),
        ],
      ),
    ],
  );

  _generateData() {
    var piedata = [
      new DisabilityPie('San José', 9169, Color(0xff3366cc)),
      new DisabilityPie('Cartago', 2785, Color(0xff990099)),
      new DisabilityPie('Alajuela', 5738, Color(0xff109618)),
      new DisabilityPie('Heredia', 2328, Color(0xfffdbe19)),
      new DisabilityPie('Puntarenas', 3492, Color(0xffff9900)),
      new DisabilityPie('Limón', 3126, Color(0xffdc3912)),
      new DisabilityPie('Guanacaste', 2775, Color(0xff00bcd4)),
    ];

    var linesalesdata1 = [
      new DisabilityLineChart(0, 0),
      new DisabilityLineChart(14, 542618),
      new DisabilityLineChart(29, 589260),
      new DisabilityLineChart(59, 763923),
      new DisabilityLineChart(64, 65432),
      new DisabilityLineChart(74, 86754),
      new DisabilityLineChart(89, 53283),
    ];

    var linesalesdata2 = [
      new DisabilityLineChart(0, 0),
      new DisabilityLineChart(14, 525212),
      new DisabilityLineChart(29, 604820),
      new DisabilityLineChart(59, 826543),
      new DisabilityLineChart(64, 72192),
      new DisabilityLineChart(74, 94828),
      new DisabilityLineChart(89, 64672),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (DisabilityPie disability, _) => disability.disability,
        measureFn: (DisabilityPie disability, _) => disability.disabilityvalue,
        colorFn: (DisabilityPie disability, _) =>
            charts.ColorUtil.fromDartColor(disability.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (DisabilityPie row, _) => '${row.disabilityvalue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff536dfe)),
        id: 'Hombres',
        data: linesalesdata1,
        domainFn: (DisabilityLineChart sales, _) => sales.age,
        measureFn: (DisabilityLineChart sales, _) => sales.disabilities,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffea80fc)),
        id: 'Mujeres',
        data: linesalesdata2,
        domainFn: (DisabilityLineChart sales, _) => sales.age,
        measureFn: (DisabilityLineChart sales, _) => sales.disabilities,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesBubbleData =
        List<charts.Series<DisabilityTypeBubbleChart, String>>();
    _seriesPieData = List<charts.Series<DisabilityPie, String>>();
    _seriesLineData = List<charts.Series<DisabilityLineChart, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.stopCircle),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Tipos de discacidad en la poblacion',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Para oir'),
                                Icon(FontAwesomeIcons.solidCircle,
                                    color: Colors.pink)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Para hablar'),
                                Icon(FontAwesomeIcons.solidCircle,
                                    color: Colors.red)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Para caminar o subir gradas'),
                                Icon(FontAwesomeIcons.solidCircle,
                                    color: Colors.blue)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Para utilizar brazos o manos'),
                                Icon(FontAwesomeIcons.solidCircle,
                                    color: Colors.green)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Del tipo intelectual'),
                                Icon(FontAwesomeIcons.solidCircle,
                                    color: Colors.orange)
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Del tipo mental'),
                                Icon(FontAwesomeIcons.solidCircle,
                                    color: Colors.purple)
                              ],
                            )
                          ],
                        )),
                        Expanded(
                          child: charts.ScatterPlotChart(
                            _createSampleData(),
                            animate: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Población con Discapacidad para Hablar en Costa Rica',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(_seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification:
                                      charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxRows: 2,
                                  cellPadding: new EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  entryTextStyle: charts.TextStyleSpec(
                                      color: charts
                                          .MaterialPalette.purple.shadeDefault,
                                      fontFamily: 'Georgia',
                                      fontSize: 11),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.inside)
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Personas con Discapacidad en Costa Rica por Sexo y Edad',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true),
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.ChartTitle('Edad',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Discapacitados',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Create one series with sample hard coded data.
List<charts.Series<DisabilityTypeBubbleChart, int>> _createSampleData() {
  final data = [
    new DisabilityTypeBubbleChart("Para oir", 3339, 7),
    new DisabilityTypeBubbleChart("Para oir", 4983, 24),
    new DisabilityTypeBubbleChart("Para oir", 20643, 45),
    new DisabilityTypeBubbleChart("Para oir", 5409, 62),
    new DisabilityTypeBubbleChart("Para oir", 12858, 69),
    new DisabilityTypeBubbleChart("Para oir", 19258, 82),
    new DisabilityTypeBubbleChart("Para oir", 4219, 95),
    new DisabilityTypeBubbleChart("Para hablar", 7331, 7),
    new DisabilityTypeBubbleChart("Para hablar", 4810, 24),
    new DisabilityTypeBubbleChart("Para hablar", 8359, 45),
    new DisabilityTypeBubbleChart("Para hablar", 1210, 62),
    new DisabilityTypeBubbleChart("Para hablar", 2469, 69),
    new DisabilityTypeBubbleChart("Para hablar", 4126, 82),
    new DisabilityTypeBubbleChart("Para hablar", 1108, 95),

    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 4749, 7),
    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 8350, 24),
    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 48919, 45),
    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 13790, 62),
    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 26710, 69),
    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 32221, 82),
    new DisabilityTypeBubbleChart("Para caminar o subir gradas", 1108, 95),

    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 2202, 7),
    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 3953, 24),
    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 19530, 45),
    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 4766, 62),
    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 8216, 69),
    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 8588, 82),
    new DisabilityTypeBubbleChart("Para utilizar brazos o manos", 1604, 95),


    new DisabilityTypeBubbleChart("Del tipo intelectual", 9571, 7),
    new DisabilityTypeBubbleChart("Del tipo intelectual", 11395, 24),
    new DisabilityTypeBubbleChart("Del tipo intelectual", 10867, 45),
    new DisabilityTypeBubbleChart("Del tipo intelectual", 766, 62),
    new DisabilityTypeBubbleChart("Del tipo intelectual", 1204, 69),
    new DisabilityTypeBubbleChart("Del tipo intelectual", 1331, 82),
    new DisabilityTypeBubbleChart("Del tipo intelectual", 282, 95),


    new DisabilityTypeBubbleChart("Del tipo mental", 2624, 7),
    new DisabilityTypeBubbleChart("Del tipo mental", 4957, 24),
    new DisabilityTypeBubbleChart("Del tipo mental", 11258, 45),
    new DisabilityTypeBubbleChart("Del tipo mental", 1429, 62),
    new DisabilityTypeBubbleChart("Del tipo mental", 2476, 69),
    new DisabilityTypeBubbleChart("Del tipo mental", 3514, 82),
    new DisabilityTypeBubbleChart("Del tipo mental", 713, 95),
  ];

  final maxMeasure = 300;

  return [
    new charts.Series<DisabilityTypeBubbleChart, int>(
      id: 'Sales',
      // Providing a color function is optional.
      colorFn: (DisabilityTypeBubbleChart sales, _) {
        // Bucket the measure column value into 3 distinct colors.

        if (sales.type.compareTo("Para oir") == 0) {
          return charts.MaterialPalette.pink.shadeDefault;
        } else if (sales.type.compareTo("Para hablar") == 0) {
          return charts.MaterialPalette.red.shadeDefault;
        } else if (sales.type.compareTo("Para caminar o subir gradas") == 0) {
          return charts.MaterialPalette.blue.shadeDefault;
        } else if (sales.type.compareTo("Para utilizar brazos o manos") == 0) {
          return charts.MaterialPalette.green.shadeDefault;
        } else if (sales.type.compareTo("Del tipo intelectual") == 0) {
          return charts.MaterialPalette.deepOrange.shadeDefault;
        } else if (sales.type.compareTo("Del tipo mental") == 0) {
          return charts.MaterialPalette.purple.shadeDefault;
        } else {
          return charts.MaterialPalette.black;
        }
      },
      domainFn: (DisabilityTypeBubbleChart sales, _) => sales.ageRange,
      measureFn: (DisabilityTypeBubbleChart sales, _) => sales.cases,
      // Providing a radius function is optional.
      radiusPxFn: (DisabilityTypeBubbleChart sales, _) =>
          (sales.cases / 117000) * 100,
      data: data,
    )
  ];
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class DisabilityPie {
  String disability;
  double disabilityvalue;
  Color colorval;

  DisabilityPie(this.disability, this.disabilityvalue, this.colorval);
}

class DisabilityLineChart {
  int age;
  int disabilities;

  DisabilityLineChart(this.age, this.disabilities);
}

class DisabilityTypeBubbleChart {
  final String type;
  final int cases;
  final int ageRange;

  DisabilityTypeBubbleChart(this.type, this.cases, this.ageRange);
}
