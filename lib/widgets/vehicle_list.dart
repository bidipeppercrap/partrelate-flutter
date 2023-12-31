import 'package:flutter/material.dart';

import '../types/vehicle.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({
    super.key,
    required this.vehicles,
    required this.onTapHandler
  });

  final List<Vehicle> vehicles;
  final Function(int) onTapHandler;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        Vehicle vehicle = vehicles[index];
        int vehicleId = vehicle.id!;

        return ListTile(
          title: Text(vehicle.name),
          onTap: () => onTapHandler(vehicleId)
        );
      },
    );
  }
}
