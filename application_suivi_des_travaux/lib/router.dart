import 'package:application_suivi_des_travaux/ui/screens/map_travaux.dart';
import 'package:application_suivi_des_travaux/ui/screens/ensemble_travaux.dart';

class AppRouter {
  static const String travauxDetails = '/travaux';
  static const String mapTravaux = '/map';

  static final routes = {
    travauxDetails: (context) => const EnsembleTravaux(),
    mapTravaux: (context) => const MapTravaux(),
  };
}
