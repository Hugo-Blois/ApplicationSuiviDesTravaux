import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/travaux_cubit.dart';
import 'router.dart';

void main() {
  // Pour pouvoir utiliser les SharePreferences avant le runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Instanciation du Cubit
  final TravauxCubit travauxCubit = TravauxCubit();

  // Chargement des entreprises
  travauxCubit.loadTravaux();

  runApp(BlocProvider<TravauxCubit>(
    create: (_) => travauxCubit,
    child: const MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Angers Travaux Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: AppRouter.routes,
      initialRoute: AppRouter.travauxDetails,
    );
  }
}
