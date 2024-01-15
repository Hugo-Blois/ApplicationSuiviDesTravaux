import 'package:application_suivi_des_travaux/repositories/travaux_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/travaux.dart';

class TravauxCubit extends Cubit<List<Travaux>> {
  /// Constructeur + initialisation du Cubit avec une liste vide de travaux
  TravauxCubit() : super([]);

  /// Méthode pour charger la liste de travaux
  Future<void> loadTravaux() async {
    final List<Travaux> travauxList = await TravauxRepository.fetchAllTravaux();
    emit(travauxList);
  }
}
