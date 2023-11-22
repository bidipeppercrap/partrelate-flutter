import 'part_to_vehicle_part.dart';

class VehiclePart {
  VehiclePart({
    this.id,
    required this.vehicleId,
    required this.name,
    this.description,
    this.note,
    this.partsToVehicleParts
  });

  int? id;
  final int vehicleId;
  final String name;
  String? description;
  String? note;
  List<PartToVehiclePart>? partsToVehicleParts;

  factory VehiclePart.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'vehicleId': int vehicleId,
        'id': int id,
        'name': String name,
        'description': String? description,
        'note': String? note,
      } => VehiclePart(
        vehicleId: vehicleId,
        id: id,
        name: name,
        description: description,
        note: note
      ),
      _ => throw const FormatException('Failed to load vehicle part.')
    };
  }
}