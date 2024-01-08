import 'package:flutter/material.dart';
import 'ui/screens/map_travaux.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Angers Travaux Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapTravaux(),
    );
  }
}
