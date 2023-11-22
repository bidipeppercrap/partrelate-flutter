import 'part.dart';

class PartToVehiclePart {
  PartToVehiclePart({
    this.id,
    required this.vehiclePartId,
    required this.partId,
    this.description,
    this.quantity,
    this.part
  });

  int? id;
  final int vehiclePartId;
  final int partId;
  String? description;
  String? quantity;
  Part? part;
}