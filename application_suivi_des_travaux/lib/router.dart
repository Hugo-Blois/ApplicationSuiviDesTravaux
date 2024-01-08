import 'package:application_suivi_des_travaux/ui/screens/travaux_details.dart';

class AppRouter {
  static const String travauxDetails = '/travaux';

  static final routes = {
    travauxDetails: (context) => const TravauxDetails(),
  };
}
