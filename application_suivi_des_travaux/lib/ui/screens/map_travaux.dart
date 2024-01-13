
import 'package:application_suivi_des_travaux/router.dart';
import 'package:application_suivi_des_travaux/ui/screens/ensemble_travaux.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../models/travaux.dart';
import '../../repositories/travaux_repository.dart';

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
    // Call the repository method to fetch travaux
    TravauxRepository.fetchAllTravaux().then((List<Travaux> travauxList) {
      // Add markers for each travaux
      for (Travaux travaux in travauxList) {
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(travaux.lat ?? 0.0, travaux.long ?? 0.0), // Coordinates for each travaux
            builder: (ctx) => GestureDetector(
              onTap: () {
                // Show a pop-up or navigate to another screen on marker click
                _showMarkerPopup(ctx, travaux);
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

      // Make sure to update the UI after adding markers
      setState(() {});
    });
  }

  // Function to show a pop-up when the marker is clicked
  void _showMarkerPopup(BuildContext context, Travaux travaux) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            travaux.titre ?? 'No title',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            travaux.description ?? 'No description',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Ferme la fenêtre contextuelle actuelle
                    _navigateToDetailTravaux(context, travaux);
                  },
                  child: const Text('Voir le détail'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _navigateToDetailTravaux(BuildContext context, Travaux travaux) {
    Navigator.of(context).pushNamed(AppRouter.detailTravaux, arguments: travaux);
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
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
