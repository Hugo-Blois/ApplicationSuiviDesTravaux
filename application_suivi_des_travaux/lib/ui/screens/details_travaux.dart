import 'package:flutter/material.dart';
import 'package:application_suivi_des_travaux/blocs/travaux_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_suivi_des_travaux/models/travaux.dart';
import 'package:intl/intl.dart';

class DetailsTravaux extends StatelessWidget {

  const DetailsTravaux({super.key});

  @override
  Widget build(BuildContext context) {

    // Récupérer les arguments depuis la route
    Travaux travaux = ModalRoute.of(context)!.settings.arguments as Travaux;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Travaux'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              travaux.titre ?? 'Pas spécifié',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            //Description du travaux
            const SizedBox(height: 16),
            const Text(
              'Description : ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              travaux.description ?? 'Pas spécifié',
              style: const TextStyle(fontSize: 18),
            ),
            //Adresse du travaux
            const SizedBox(height: 16),
            const Text(
              'Adresse : ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              travaux.address ?? 'Pas spécifié',
              style: const TextStyle(fontSize: 18),
            ),
            //Date du travaux
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre "Date du chantier"
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.date_range, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Dates du chantier : ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Début du chantier
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Débute le : ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatDate(travaux.startAt!) ?? 'Pas spécifié',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Fin du chantier
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Termine le : ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          formatDate(travaux.endAt!) ?? 'Pas spécifié',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Nombre de jours que dure le chantier
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, size: 24),
                    const SizedBox(width: 8),
                    const Text(
                      'Durée : ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      calculateNumberOfDaysText(travaux.startAt!, travaux.endAt!),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            //Affectation sur le traffic
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.traffic, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Traffic : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  travaux.traffic == 'slow'
                      ? 'Traffic Ralenti'
                      : travaux.traffic == 'deviated'
                      ? 'Route barrée - Déviation'
                      : 'Pas spéficié',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            //Contact si problème
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.contact_phone, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Contact : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  travaux.contact ?? 'Pas spécifié',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            //Email de contact
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.email, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Email : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  travaux.email ?? 'Pas spécifié',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            //Affectation Tarmway
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.train, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Tramway affecté : ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  travaux.isTramway == 1 ? 'Oui' : 'Non',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            // Add more details as needed
          ],
        ),
      ),
    );

  }

  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();

    return '$day ${getMonthName(month)} $year';
  }

  int calculateNumberOfDays(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    Duration difference = endDate.difference(startDate);
    return difference.inDays+1;
  }

  String calculateNumberOfDaysText(String start, String end) {
    int numberOfDays = calculateNumberOfDays(start, end);

    if (numberOfDays == 1) {
      return '$numberOfDays jour';
    } else {
      return '$numberOfDays jours';
    }
  }

  String getMonthName(String month) {
    switch (month) {
      case '01':
        return 'Janvier';
      case '02':
        return 'Février';
      case '03':
        return 'Mars';
      case '04':
        return 'Avril';
      case '05':
        return 'Mai';
      case '06':
        return 'Juin';
      case '07':
        return 'Juillet';
      case '08':
        return 'Août';
      case '09':
        return 'Septembre';
      case '10':
        return 'Octobre';
      case '11':
        return 'Novembre';
      case '12':
        return 'Décembre';
      default:
        return '';
    }
  }

}
