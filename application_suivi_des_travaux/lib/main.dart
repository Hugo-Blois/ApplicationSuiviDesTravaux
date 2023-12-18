import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angers Travaux Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyMap(),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  MapController mapController = MapController();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      'https://api.url.de.la.ville.d.angers/info-travaux?fbclid=IwAR3pTTDTD7lqQICHFaCG9_WtI6P6vZc4vJzU-ydD5hkt2tgOTv3PhTc-Jho' as Uri,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> works = data['works'];

      for (var work in works) {
        double lat = work['latitude'];
        double lon = work['longitude'];
        markers.add(
          Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(lat, lon),
            builder: (ctx) => Container(
              child: Icon(Icons.work),
            ),
          ),
        );
      }

      setState(() {});
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  void zoomIn() {
    mapController.move(mapController.center, mapController.zoom + 1);
  }

  void zoomOut() {
    mapController.move(mapController.center, mapController.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(47.47678, -0.56223),
              zoom: 15.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: markers),
            ],
          ),
          Positioned(
            top: 100, // Ajuster la valeur pour déplacer les boutons plus bas
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: zoomIn,
                  child: Icon(Icons.add),
                  mini: true,
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: zoomOut,
                  child: Icon(Icons.remove),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
