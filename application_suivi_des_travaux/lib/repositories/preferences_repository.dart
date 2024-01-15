import 'package:application_suivi_des_travaux/models/notes.dart';
import 'package:application_suivi_des_travaux/models/travaux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  Future<void> saveNotes(List<Notes> notes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> listJson = [];

    // for (final Travaux company in companies) {
    //   listJson.add(jsonEncode(company.toJson()));
    // }
    // prefs.setStringList('companies', listJson);
  }

  Future<List<Notes>> loadNotes(Travaux travaux) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Notes> companies = [];

    // final listJson = prefs.getStringList('companies') ?? [];
    // for (final String json in listJson) {
    //   companies.add(Company.fromJson(jsonDecode(json)));
    // }

    return companies;
  }
}
