import 'package:flutter/material.dart';
import 'package:locationapp/locator/location_home.dart';
import 'package:locationapp/locator/locator_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Location',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => LocatorBloc(),
        child: LocationHome(),
      ),
    );
  }
}
