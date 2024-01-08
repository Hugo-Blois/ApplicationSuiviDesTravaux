import 'dart:convert';
import 'package:http/http.dart';
import 'package:application_suivi_des_travaux/models/travaux.dart';

class TravauxRepository {
  static Future<Travaux> fetchTravaux(int id) async {
    final Response response = await get(Uri.parse(
        'https://data.angers.fr/api/explore/v2.1/catalog/datasets/info-travaux/records?where=id%20%3D%2085596'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> results = jsonData['results'];

      if (results.isNotEmpty) {
        final Map<String, dynamic> travauxData = results[0];

        final Travaux travaux = Travaux(
          id: travauxData['id'],
          titre: travauxData['title'],
          description: travauxData['description'],
          address: travauxData['address'],
          startAt: travauxData['startat'],
          endAt: travauxData['endat'],
          traffic: travauxData['traffic'],
          contact: travauxData['contact'],
          email: travauxData['email'],
          isTramway: travauxData['istramway'],
          long: travauxData["geo_point_2d"]["lon"],
          lat: travauxData["geo_point_2d"]["lat"],
        );

        return travaux;
      } else {
        throw Exception('No travaux found');
      }
    } else {
      throw Exception('Failed to load travaux');
    }
  }
}
