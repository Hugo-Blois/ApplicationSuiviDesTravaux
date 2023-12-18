import 'dart:convert';

import 'package:application_suivi_des_travaux/models/travaux.dart';
import 'package:http/http.dart';

class TravauxRepository {
  Future<Travaux> fetchTravaux(int id) async {
    final Response response = await get(Uri.parse(
        'https://data.angers.fr/api/explore/v2.1/catalog/datasets/info-travaux/records?where=id%20%3D%2085481&limit=20'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      final Travaux travaux = Travaux(
          id: json['id'],
          titre: json['title'],
          description: json['description'],
          address: json['address'],
          startAt: json['startAt'],
          endAt: json['endAt'],
          traffic: json['traffic'],
          contact: json['contact'],
          email: json['email'],
          isTramway: json['isTramway'],
          long: json["geo_point_2d"]["lon"],
          lat: json["geo_point_2d"]["lat"]);

      print(travaux);

      return travaux;
    } else {
      throw Exception('Failed to load addresses');
    }
  }
}
