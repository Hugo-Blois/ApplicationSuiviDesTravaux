import 'dart:convert';

import 'package:application_suivi_des_travaux/ui/screens/ensemble_travaux.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import '../../blocs/travaux_cubit.dart';
import '../../models/travaux.dart';


class MapTravaux extends StatefulWidget {
  const MapTravaux({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapTravauxState createState() => _MapTravauxState();
}

class _MapTravauxState extends State<MapTravaux> {
  MapController mapController = MapController();
  List<Marker> markers = [];

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

      setState(() {});
    } else {
      if (kDebugMode) {
        print('Failed to fetch data: ${response.statusCode}');
      }
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
                  mini: true,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: zoomOut,
                  mini: true,
                  child: const Icon(Icons.remove),
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
                    builder: (context) => const EnsembleTravaux(),
                  ),
                );
              },
              child: const Text('Voir tous les travaux'),
            ),
          ),
        ],
      ),
    );
  }
}
