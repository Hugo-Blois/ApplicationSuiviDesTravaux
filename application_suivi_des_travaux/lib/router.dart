import 'package:application_suivi_des_travaux/ui/screens/map_travaux.dart';
import 'package:application_suivi_des_travaux/ui/screens/travaux_details.dart';

class AppRouter {
  static const String travauxDetails = '/travaux';
  static const String mapTravaux = '/map';

  static final routes = {
    travauxDetails: (context) => const TravauxDetails(),
    mapTravaux: (context) => const MapTravaux(),
  };
}
