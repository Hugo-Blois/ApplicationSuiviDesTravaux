import 'dart:convert';

import 'package:application_suivi_des_travaux/work_zone_details_page.dart';
import 'package:application_suivi_des_travaux/work_zone_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'work_zone.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  MapController mapController = MapController();
  List<Marker> markers = [];
  List<WorkZone> workZones = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      'https://data.angers.fr/api/explore/v2.1/catalog/datasets/info-travaux/records?limit=20' as Uri,
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      for (var record in data) {
        WorkZone workZone = WorkZone.fromJson(record);
        workZones.add(workZone);

        double lat = workZone.location.coordinates[1];
        double lon = workZone.location.coordinates[0];
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

  void goToWorkZoneDetails(WorkZone workZone) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkZoneDetailsPage(workZone),
      ),
    );
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
            top: 100,
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
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () {
                // Naviguer vers la page des détails des travaux
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkZoneListPage(workZones),
                  ),
                );
              },
              child: Text('Voir les travaux'),
            ),
          ),
        ],
      ),
    );
  }
}
