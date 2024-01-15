import 'package:application_suivi_des_travaux/repositories/preferences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/notes_cubit.dart';
import 'blocs/travaux_cubit.dart';
import 'router.dart';

void main() {
  // Pour pouvoir utiliser les SharePreferences avant le runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Instanciation du Cubit
  final TravauxCubit travauxCubit = TravauxCubit();
  final NotesCubit noteCubit = NotesCubit(PreferencesRepository());

  // Chargement des entreprises
  travauxCubit.loadTravaux();
  noteCubit.loadNotes();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TravauxCubit>(create: (_) => travauxCubit),
      BlocProvider<NotesCubit>(create: (_) => noteCubit),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angers Travaux Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: AppRouter.routes,
      initialRoute: AppRouter.mapTravaux,
    );
  }
}
