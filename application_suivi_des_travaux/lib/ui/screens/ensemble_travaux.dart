import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/travaux.dart';
import '../../repositories/travaux_repository.dart';

class EnsembleTravaux extends StatefulWidget {
  const EnsembleTravaux({Key? key}) : super(key: key);

  @override
  _EnsembleTravauxState createState() => _EnsembleTravauxState();
}

class _EnsembleTravauxState extends State<EnsembleTravaux> {
  List<Travaux> _travaux = [];
  List<Travaux> _filteredTravaux = [];
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _selectedSearchType = 'Adresse';

  @override
  void initState() {
    super.initState();
    TravauxRepository.fetchAllTravaux().then((value) {
      setState(() {
        _travaux = value;
        _filteredTravaux = _travaux;
      });
    });
  }

  void _onTravauxChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _filteredTravaux = _travaux.where((travaux) {
          final String lowerCaseValue = value.toLowerCase();
          if (_selectedSearchType == 'Adresse') {
            return travaux.address?.toLowerCase().contains(lowerCaseValue) ??
                false;
          } else if (_selectedSearchType == 'Titre') {
            return travaux.titre?.toLowerCase().contains(lowerCaseValue) ??
                false;
          } else if (_selectedSearchType == 'Description') {
            return travaux.description
                    ?.toLowerCase()
                    .contains(lowerCaseValue) ??
                false;
          }
          return false;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche des travaux :'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Ajout de padding
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 15.0), // Ajout de padding
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Rechercher des travaux',
                      ),
                      onChanged: _onTravauxChanged,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0), // Ajout de padding
                  child: DropdownButton<String>(
                    value: _selectedSearchType,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSearchType = newValue;
                        });
                      }
                    },
                    items: <String>['Adresse', 'Titre', 'Description']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTravaux.length,
              itemBuilder: (context, index) {
                final Travaux travaux = _filteredTravaux[index];

                String formatDate(String dateString) {
                  final DateTime dateTime = DateTime.parse(dateString);
                  return DateFormat('dd/MM/yyyy').format(dateTime);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: RichText(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: RichText(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: RichText(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: RichText(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: RichText(
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
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
