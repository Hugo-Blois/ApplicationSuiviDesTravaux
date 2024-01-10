import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application_suivi_des_travaux/models/travaux.dart';

class TravauxRepository {
  static Future<List<Travaux>> fetchAllTravaux() async {
    final response = await http.get(Uri.parse(
        'https://data.angers.fr/api/explore/v2.1/catalog/datasets/info-travaux/exports/geojson?lang=fr&timezone=Europe%2FBerlin'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> geoJson = jsonDecode(response.body);

      final List<dynamic> features = geoJson['features'];

      List<Travaux> travauxList = [];

      for (var feature in features) {
        final properties = feature['properties'];

        final Travaux travaux = Travaux(
          id: properties['id'],
          titre: properties['title'],
          description: properties['description'],
          address: properties['address'],
          startAt: properties['startat'],
          endAt: properties['endat'],
          traffic: properties['traffic'],
          contact: properties['contact'],
          email: properties['email'],
          isTramway: properties['istramway'],
          long: feature['geometry']['coordinates']
              [0], // GeoJSON uses [longitude, latitude]
          lat: feature['geometry']['coordinates'][1],
        );

        travauxList.add(travaux);
      }

      return travauxList;
    } else {
      throw Exception('Failed to load travaux');
    }
  }
}
