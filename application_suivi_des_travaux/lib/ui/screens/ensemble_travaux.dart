import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/travaux_cubit.dart';
import '../../models/travaux.dart';

class EnsembleTravaux extends StatefulWidget {
  const EnsembleTravaux({Key? key}) : super(key: key);

  @override
  _EnsembleTravauxState createState() => _EnsembleTravauxState();
}

class _EnsembleTravauxState extends State<EnsembleTravaux> {
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

                // Fonction pour formater la date
                String formatDate(String dateString) {
                  final DateTime dateTime = DateTime.parse(dateString);
                  return DateFormat('dd/MM/yyyy').format(dateTime);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Titre: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: travaux.titre ?? ''),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Description : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: travaux.description ?? ''),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Address : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: travaux.address ?? ''),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Date de début : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: formatDate(travaux.startAt ?? '')),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Date de fin : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: formatDate(travaux.endAt ?? '')),
                        ],
                      ),
                    ),
                    // Ajoutez les autres champs en utilisant le même modèle
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
