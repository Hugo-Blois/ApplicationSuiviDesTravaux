import 'package:application_suivi_des_travaux/ui/screens/travaux_details.dart';

class AppRouter {
  static const String homePage = '/home';
  static const String addCompanyPage = '/add_company';
  static const String searchAddress = '/search_address';

  static final routes = {
    homePage: (context) => const TravauxDetails(),
  };
}
