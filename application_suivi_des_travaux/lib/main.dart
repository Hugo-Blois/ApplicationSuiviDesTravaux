import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        'https://api.url.de.la.ville.d.angers/info-travaux?fbclid=IwAR3pTTDTD7lqQICHFaCG9_WtI6P6vZc4vJzU-ydD5hkt2tgOTv3PhTc-Jho' as Uri);

    if (response.statusCode == 200) {
      // Parse JSON response
      Map<String, dynamic> data = json.decode(response.body);

      // Assuming the API response has a 'works' field containing a list of works
      List<dynamic> works = data['works'];

      // Add markers to the map
      for (var work in works) {
        double lat = work['latitude'];
        double lon = work['longitude'];
        markers.add(Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(lat, lon),
          builder: (ctx) => Container(
            child: Icon(Icons.work),
          ),
        ));
      }

      setState(() {});
    } else {
      // Handle error
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Angers Travaux Map'),
      ),
      body: FlutterMap(
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
    );
  }
}
