import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  return runApp(MapsApp());
}

/// This widget will be the root of application.
class MapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Maps Demo',
      home: MyHomePage(),
    );
  }
}

/// This widget is the home page of the application.
class MyHomePage extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage] class.
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

// MapLatLng p1=MapLatLng(31.083332, longitude)
  late List<Model> _data;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    _data = const <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          '       New\nSouth Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];

    _mapSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Center(
          child: SfMaps(
            layers: [
              MapTileLayer(
                zoomPanBehavior: MapZoomPanBehavior(),
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/vaibhav72/ckpp36jn70jki18pbiopnzaid/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidmFpYmhhdjcyIiwiYSI6ImNrcHAzM3FzZTE4NHQycHFxa3Znb3MwZ3kifQ.OOnIxS-xtsYGBU3TSb_BYA',
                sublayers: [
                  MapArcLayer(
                      arcs: [
                    MapArc(
                        color: Colors.red,
                        controlPointFactor: 0.5,
                        to: MapLatLng(28.6139, 77.2090),
                        from: MapLatLng(12.9141, 74.8560)),
                    MapArc(
                        color: Colors.red,
                        from: MapLatLng(12.9141, 74.8560),
                        to: MapLatLng(17.3850, 78.4867)),
                    MapArc(
                        color: Colors.red,
                        from: MapLatLng(17.3850, 78.4867),
                        to: MapLatLng(22.9734, 78.6569))
                    // MapArc(
                    //     controlPointFactor: 0.5,
                    //     color: Colors.red,
                    //     from: MapLatLng(-37.020100, 144.964600),
                    //     to: MapLatLng(-19.491411, 132.550964)),
                    // MapArc(
                    //     color: Colors.red,
                    //     controlPointFactor: 0.5,
                    //     heightFactor: 0.1,
                    //     from: MapLatLng(-19.491411, 132.550964),
                    //     to: MapLatLng(-33.185833, 138.016937)),
                    // MapArc(
                    //     color: Colors.red,
                    //     heightFactor: 0.1,
                    //     from: MapLatLng(-25.042261, 117.793221),
                    //     to: MapLatLng(-37.020100, 144.964600)),
                  ].toSet())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Collection of Australia state code data.
class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}
