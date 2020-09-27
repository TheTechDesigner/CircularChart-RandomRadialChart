import 'dart:math';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class ColorPalette {
  static final ColorPalette _palette = ColorPalette(<Color>[
    Color(0xFFC41A3B),
    Colors.pinkAccent,
    Color(0xFF1B1F32),
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ]);
  ColorPalette(List<Color> _colors) : _color = _colors {
    assert(_colors.isNotEmpty);
  }
  final List<Color> _color;
  Color operator [](int index) => _color[index % _length];
  int get _length => _color.length;
  Color _random(Random _random) => this[_random.nextInt(_length)];
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<AnimatedCircularChartState> _chartkey = GlobalKey<AnimatedCircularChartState>();

  String title = 'Circular Chart (3. Random Radial Chart)';

  List<CircularStackEntry> _chartData;
  final _size = Size(400.0, 400.0);

  final Math.Random _random = Math.Random();

  @override
  void initState() {
    super.initState();
    _chartData = _generateRandomData();
  }

  void _randoms() {
    setState(() {
      _chartData = _generateRandomData();
      _chartkey.currentState.updateData(_chartData);
    });
  }

  List<CircularStackEntry> _generateRandomData() {
    int _stackCount = _random.nextInt(16);
    List<CircularStackEntry> _chartData = List.generate(_stackCount, (index) {
      int _segmentCount = _random.nextInt(16);
      List<CircularSegmentEntry> _segment = List.generate(_segmentCount, (j) {
        Color _randomColor = ColorPalette._palette._random(_random);
        return CircularSegmentEntry(_random.nextDouble(), _randomColor);
      });
      return CircularStackEntry(_segment);
    });
    return _chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartkey,
          size: _size,
          initialChartData: _chartData,
          chartType: CircularChartType.Radial,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randoms,
        backgroundColor: Color(0xFFC41A3B),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
