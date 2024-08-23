import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jai_poc/core/heatmaputils/src/plugin/heatmap_data_provider.dart';
import 'package:jai_poc/core/heatmaputils/src/plugin/heatmap_layer.dart';
import 'package:jai_poc/core/heatmaputils/src/plugin/latlong.dart';
import 'package:jai_poc/core/widgets/custom-app_bar.dart';
import 'package:latlong2/latlong.dart';
import '../../core/heatmaputils/src/heatmap/heat_map_options.dart';


class HeatMap extends StatefulWidget {
  HeatMap({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HeatMap> {
  final StreamController<void> _rebuildStream = StreamController.broadcast();
  List<WeightedLatLng> data = [];
  List<Map<double, MaterialColor>> gradients = [
    HeatMapOptions.defaultGradient,
    {0.25: Colors.blue, 0.55: Colors.red, 0.85: Colors.pink, 1.0: Colors.purple}
  ];

  var index = 0;
  var zoom = 8.0;

  initState() {
    _loadData();
    super.initState();
  }

  @override
  dispose() {
    _rebuildStream.close();
    super.dispose();
  }

  _loadData() async {
    var str = await rootBundle.loadString('assets/initial_data.json');
    List<dynamic> result = jsonDecode(str);

    setState(() {
      data = result
          .map((e) => e as List<dynamic>)
          .map((e) => WeightedLatLng(LatLng(e[0], e[1]), 1))
          .toList();
      print(data);
    });
  }

  void _incrementCounter() {
    setState(() {
      index = index == 0 ? 1 : 0;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _rebuildStream.add(null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _rebuildStream.add(null);
    });

    final map = FlutterMap(
      options: MapOptions(
          center: LatLng(31.636733073137822, 74.86977243703173), zoom: zoom),
      children: [
        TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c']),
        if (data.isNotEmpty)
          HeatMapLayer(
            heatMapDataSource: InMemoryHeatMapDataSource(data: data),
            heatMapOptions:
                HeatMapOptions(gradient: gradients[index], minOpacity: 0.1),
            reset: _rebuildStream.stream,
          )
      ],
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: "Flutter Heat Map",
      ),
      backgroundColor: Colors.pink,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(child: map),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Switch Gradient',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
