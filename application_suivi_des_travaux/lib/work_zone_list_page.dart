import 'package:application_suivi_des_travaux/work_zone_details_page.dart';
import 'package:flutter/material.dart';
import 'work_zone.dart';

class WorkZoneListPage extends StatelessWidget {
  final List<WorkZone> workZones;

  const WorkZoneListPage(this.workZones, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des travaux'),
      ),
      body: ListView.builder(
        itemCount: workZones.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workZones[index].title),
            subtitle: Text(workZones[index].description),
            onTap: () {
              // Aller à la page de détails des travaux en passant l'objet WorkZone
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkZoneDetailsPage(workZones[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
