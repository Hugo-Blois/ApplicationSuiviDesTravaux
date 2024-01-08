import 'dart:convert';

import 'package:application_suivi_des_travaux/ui/screens/ensemble_travaux.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
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
    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(47.49311114 ,  -0.5514251), // Coordinates for the point
        builder: (ctx) => GestureDetector(
          onTap: () {
            // Show a pop-up or navigate to another screen on marker click
            _showMarkerPopup(ctx);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.red, // Customize marker color if needed
            size: 40.0,
          ),
        ),
      ),
    );
  }

  // Function to show a pop-up when the marker is clicked
  void _showMarkerPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Marker Clicked'),
          content: const Text('You clicked the marker at 10 boulevard Jean Jeanneteau, Angers.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
              center: LatLng(47.4736, -0.5544),
              zoom: 13.5,
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
