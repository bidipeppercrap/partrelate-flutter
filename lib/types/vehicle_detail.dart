import 'vehicle.dart';
import 'vehicle_part.dart';
import 'part_to_vehicle_part.dart';
import 'part.dart';

class VehicleDetail extends Vehicle {
  VehicleDetail({
    super.id,
    required super.name,
    super.description,
    super.note,
    this.vehicleParts
  });

  List<VehiclePart>? vehicleParts = [];

  @override
  factory VehicleDetail.fromJson(Map<String, dynamic> json) {
    List<VehiclePart> vehicleParts = [];

    for (final data in json['vehicleParts']) {
      List<PartToVehiclePart> partsToVehicleParts = [];

      for (final ptvpData in data['partsToVehicleParts']) {
        final partData = ptvpData['parts'];
        final part = Part(
          id: partData['id'],
          name: partData['name'],
          description: partData['description'],
          note: partData['note']
        );

        final ptvp = PartToVehiclePart(
          id: ptvpData['id'],
          vehiclePartId: ptvpData['vehiclePartId'],
          partId: ptvpData['partId'],
          description: ptvpData['description'],
          quantity: ptvpData['quantity'],
          part: part
        );

        partsToVehicleParts.add(ptvp);
      }

      final vehiclePart = VehiclePart(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        note: data['note'],
        vehicleId: json['id'],
        partsToVehicleParts: partsToVehicleParts
      );

      vehicleParts.add(vehiclePart);
    }

    return switch (json) {
      {
      'id': int id,
      'name': String name,
      'description': String? description,
      'note': String? note,
      } => VehicleDetail(
          id: id,
          name: name,
          description: description,
          note: note,
          vehicleParts: vehicleParts
      ),
      _ => throw const FormatException('Failed to load vehicle detail.')
    };
  }
}