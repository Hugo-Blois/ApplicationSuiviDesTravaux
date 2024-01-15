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
  _MapTravauxState createState() => _MapTravauxState();
}

class _MapTravauxState extends State<MapTravaux> {
  MapController mapController = MapController();
  List<Marker> markers = [];
  DateTime currentDate = DateTime.now();
  List<Travaux> allTravaux = [];
  bool showAllTravaux = false;

  @override
  void initState() {
    super.initState();
    TravauxRepository.fetchAllTravaux().then((List<Travaux> travauxList) {
      allTravaux = travauxList;
      updateMarkers(allTravaux);
    });
  }

  void updateMarkers(List<Travaux> travauxList) {
    markers.clear();
    for (Travaux travaux in travauxList) {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: LatLng(travaux.lat ?? 0.0, travaux.long ?? 0.0),
          builder: (ctx) => GestureDetector(
            onTap: () {
              _showMarkerPopup(ctx, travaux);
            },
            child: const Icon(
              Icons.location_on,
              color: Colors.redAccent,
              size: 40.0,
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  void filterOrShowAllTravaux() {
    if (showAllTravaux) {
      TravauxRepository.fetchAllTravaux().then((List<Travaux> travauxList) {
        allTravaux = travauxList;
        updateMarkers(allTravaux);
      });
    } else {
      filterTravauxFromDate();
    }

    setState(() {
      showAllTravaux = !showAllTravaux;
    });
  }

  void filterTravauxFromDate() {
    List<Travaux> filteredTravaux = allTravaux
        .where((travaux) {
      if (travaux.endAt != null) {
        // Assuming the date format is 'yyyy-MM-dd'
        DateTime endDate = DateTime.parse(travaux.endAt!);
        return endDate.isAfter(currentDate);
      } else {
        return false;
      }
    })
        .toList();
    updateMarkers(filteredTravaux);
  }

  void _showMarkerPopup(BuildContext context, Travaux travaux) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
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
                      Navigator.of(context)
                          .pop();
                      _navigateToDetailTravaux(context, travaux);
                    },
                    child: const Text('Voir le détail'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  void _navigateToDetailTravaux(BuildContext context, Travaux travaux) {
    Navigator.of(context)
        .pushNamed(AppRouter.detailTravaux, arguments: travaux);
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Carte des Travaux d'Angers",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightGreen[800],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen[800],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description du Projet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Bienvenue dans l'application de suivi des travaux d'Angers.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Cette application vous permet de visualiser les travaux terminés et en cours mais aussi d'obtenir des informations détaillées sur chaque chantier.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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
            top: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: filterOrShowAllTravaux,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[800],
              ),
              child: Text(
                showAllTravaux
                    ? 'Voir tous les travaux'
                    : 'Afficher les travaux à partir d\'aujourd\'hui',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen[800],
              ),
              child: const Text(
                'Voir la liste des travaux',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
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
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const EnsembleTravaux(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
