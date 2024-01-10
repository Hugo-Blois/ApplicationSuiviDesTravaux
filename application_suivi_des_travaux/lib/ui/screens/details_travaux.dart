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
              travaux.titre ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              travaux.description ?? 'No Description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Adresse:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              travaux.address ?? 'No Address',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time, size: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Débute le :',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatDate(travaux.startAt!) ?? 'Not specified',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.access_time, size: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Termine le:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formatDate(travaux.endAt!) ?? 'Not specified',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.traffic, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Traffic: ${travaux.traffic ?? 'Not specified'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.contact_phone, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Contact: ${travaux.contact ?? 'Not specified'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.email, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Email: ${travaux.email ?? 'Not specified'}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.train, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Is tramway: ${travaux.isTramway ?? 'Not specified'}',
                  style: const TextStyle(fontSize: 16),
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
