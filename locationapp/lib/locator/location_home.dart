import 'package:flutter/material.dart';
import 'package:locationapp/locator/locator_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationHome extends StatefulWidget {
  const LocationHome({super.key});

  @override
  State<LocationHome> createState() => _LocationHomeState();
}

class _LocationHomeState extends State<LocationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            'Geo Location',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocConsumer<LocatorBloc, LocatorState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LocatorInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<LocatorBloc>().add(LocatorClickedEvent());
                },
                child: const Text(
                  'Locate Me!',
                ),
              ),
            );
          } else if (state is FetchingLocationState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocatedState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'City: ${state.cityName}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  Text(
                    'Lat: ${state.lat.toString()} Long: ${state.lng.toString()}',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Error',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
