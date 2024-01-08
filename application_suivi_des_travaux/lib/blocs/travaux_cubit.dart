import 'package:application_suivi_des_travaux/repositories/travaux_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/travaux.dart';

class TravauxCubit extends Cubit<Travaux> {
  /// Constructeur + initialisation du Cubit avec un tableau vide d'entreprise
  TravauxCubit() : super(Travaux());

  /// Méthode pour charger la liste d'entreprise
  Future<void> loadTravaux() async {
    try {
      final Travaux travaux = await TravauxRepository.fetchTravaux(85596);
      emit(travaux);
    } catch (e) {
      print('Erreur lors du chargement des travaux : $e');
    }
  }
}
