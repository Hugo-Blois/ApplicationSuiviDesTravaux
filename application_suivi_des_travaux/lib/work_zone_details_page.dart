import 'package:flutter/material.dart';
import 'work_zone.dart';

class WorkZoneDetailsPage extends StatelessWidget {
  final WorkZone workZone;

  WorkZoneDetailsPage(this.workZone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails des travaux'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Titre: ${workZone.title}'),
            Text('Description: ${workZone.description}'),
            Text('Adresse: ${workZone.address}'),
            Text('Début: ${workZone.startAt.toLocal()}'),
            Text('Fin: ${workZone.endAt.toLocal()}'),
            Text('Trafic: ${workZone.traffic}'),
            Text('Contact: ${workZone.contact}'),
            Text('Email: ${workZone.email}'),
            Text('Latitude: ${workZone.location.coordinates[1]}'),
            Text('Longitude: ${workZone.location.coordinates[0]}'),
          ],
        ),
      ),
    );
  }
}
