import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/travaux_cubit.dart';
import '../../models/travaux.dart';

class TravauxDetails extends StatelessWidget {
  const TravauxDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails des travaux :'),
      ),
      body: BlocBuilder<TravauxCubit, Travaux>(builder: (context, travaux) {
        return travaux != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${travaux.id ?? ''}'),
                    Text('Titre: ${travaux.titre ?? ''}'),
                    Text('Description: ${travaux.description ?? ''}'),
                    Text('Address: ${travaux.address ?? ''}'),
                    Text('Start At: ${travaux.startAt ?? ''}'),
                    Text('End At: ${travaux.endAt ?? ''}'),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }
}
