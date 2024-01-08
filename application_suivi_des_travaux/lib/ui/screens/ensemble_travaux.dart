import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/travaux_cubit.dart';
import '../../models/travaux.dart';

class EnsembleTravaux extends StatelessWidget {
  const EnsembleTravaux({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails des travaux :'),
      ),
      body: BlocBuilder<TravauxCubit, List<Travaux>>(
        builder: (context, travauxList) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: travauxList.length,
              itemBuilder: (context, index) {
                final Travaux travaux = travauxList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${travaux.id ?? ''}'),
                    Text('Titre: ${travaux.titre ?? ''}'),
                    Text('Description: ${travaux.description ?? ''}'),
                    Text('Address: ${travaux.address ?? ''}'),
                    Text('Start At: ${travaux.startAt ?? ''}'),
                    Text('End At: ${travaux.endAt ?? ''}'),
                    Text('Traffic : ${travaux.traffic ?? ''}'),
                    Text('Contact: ${travaux.contact ?? ''}'),
                    Text('Email: ${travaux.email ?? ''}'),
                    Text('Tramway: ${travaux.isTramway ?? ''}'),
                    Text('Longitude: ${travaux.long ?? ''}'),
                    Text('Latitude: ${travaux.lat ?? ''}'),
                    const Divider(), // Ajout d'une ligne de division entre chaque travail
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
