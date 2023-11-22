import 'package:flutter/material.dart';

import '../types/vehicle.dart';
import 'padbox.dart';

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
      itemCount: vehicles.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const PadBox(title: 'Start of Vehicles');
        }

        if (index == vehicles.length + 1) {
          return const PadBox(title: 'End of Vehicles');
        }

        Vehicle vehicle = vehicles[index - 1];
        int vehicleId = vehicle.id!;

        return ListTile(
          title: Text(vehicle.name),
          onTap: () => onTapHandler(vehicleId)
        );
      },
    );
  }
}
