import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/parts_to_vehicle_parts.dart';
import '../stores/vehicle_parts.dart';
import '../types/part.dart';
import '../types/vehicle_part.dart';
import '../types/part_to_vehicle_part.dart';
import 'assign_part_dialog.dart';
import 'part_description_dialog.dart';
import 'detail_action_buttons.dart';
import 'vehicle_part_detail_body.dart';
import 'edit_assigned_part_dialog.dart';
import '../screens/vehicle_part_edit.dart';

class VehiclePartList extends ConsumerWidget {
  const VehiclePartList({
    super.key,
    required this.vehicleParts,
    required this.refreshState
  });

  final List<VehiclePart>? vehicleParts;
  final Function() refreshState;

  Future<void> _showAssignPartDialog(BuildContext context, VehiclePart vehiclePart) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AssignPartDialog(
        onCreated: refreshState,
        vehiclePart: vehiclePart,
      )
    );
  }

  ListTile generateSpacer(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black26,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleEditVehiclePart(VehiclePart vehiclePart) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehiclePartEditScreen(
            vehiclePart: vehiclePart
          ),
          maintainState: false,
        ),
      ).then((_) {
        if (!context.mounted) return;
        refreshState.call();
      });
    }

    Future<void> deleteVehiclePart(int id) async {
      final repository = ref.read(vehiclePartsRepositoryProvider);

      await repository.delete(id);
      refreshState.call();
    }

    if (vehicleParts == null || vehicleParts!.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No parts yet.')
        )
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vehicleParts!.length,
      itemBuilder: (context, index) {
        final vehiclePart = vehicleParts![index];
        final partsToVehicleParts = vehiclePart.partsToVehicleParts ?? [];

        return ExpansionTile(
          title: Text(vehiclePart.name),
          backgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.all(0),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: VehiclePartDetailBody(
                  description: vehiclePart.description,
                  note: vehiclePart.note
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: DetailActionButtons(
                  handleDelete: () => deleteVehiclePart.call(vehiclePart.id!),
                  handleEdit: () => handleEditVehiclePart.call(vehiclePart)
              )
            ),
            generateSpacer('Start'),
            const Divider(),
            PartsToVehiclePartsBuilder(
              list: partsToVehicleParts,
              vehiclePart: vehiclePart,
              refreshState: refreshState,
            ),
            const Divider(),
            generateSpacer('End'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _showAssignPartDialog(context, vehiclePart),
                      child: const Icon(Icons.add))
                  )
                ],
              )
            ),
          ],
        );
      },
    );
  }
}

class PartsToVehiclePartsBuilder extends ConsumerWidget {
  const PartsToVehiclePartsBuilder({
    super.key,
    required this.list,
    required this.vehiclePart,
    required this.refreshState
  });
  
  final List<PartToVehiclePart> list;
  final VehiclePart vehiclePart;
  final Function() refreshState;
  
  Widget descriptionBuilder(String description) {
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 3, right: 6, left: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
              color: Colors.black12,
              width: 2
          ),
          color: Colors.black12
      ),
      child: Text(
        description,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 9,
            color: Colors.black54
        ),
      )
    );
  }
  Widget quantityBuilder(String quantity) {
    return Container(
        padding: const EdgeInsets.only(top: 3, bottom: 3, right: 6, left: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
                color: Colors.black12,
                width: 2
            ),
            color: Colors.lightBlue[100]
        ),
        child: Text(
          quantity,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black54
          ),
        )
    );
  }
  Widget partBuilder(Part part) {
    List<Widget> children = [];
    
    children.add(Text(
      part.name,
      style: const TextStyle(
          fontWeight: FontWeight.bold
      ),
    ));

    return Row(
      children: children,
    );
  }
  Widget partNoteBuilder(Part part) {
    return Container(
        padding: const EdgeInsets.only(top: 3, bottom: 3, right: 6, left: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
                color: Colors.black12,
                width: 2
            ),
            color: Colors.yellow[600]
        ),
        child: Text(
          part.note!,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black54
          ),
        )
    );
  }
  Widget titleBuilder(PartToVehiclePart data) {
    final part = data.part!;
    List<Widget> children = [];

    if (data.description != null && data.description!.isNotEmpty) {
      children.add(descriptionBuilder(data.description!));
      children.add(const SizedBox(height: 8,));
    }

    children.add(partBuilder(part));

    if (data.quantity != null && data.quantity!.isNotEmpty) {
      children.add(const SizedBox(height: 8,));
      children.add(quantityBuilder(data.quantity!));
    }

    if (part.note != null && part.note!.isNotEmpty) {
      children.add(const SizedBox(height: 8,));
      children.add(partNoteBuilder(part));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
    );
  }
  Widget? subtitleBuilder(PartToVehiclePart data) {
    if (data.part == null) return null;
    if (data.part!.description != null && data.part!.description!.isNotEmpty) {
      return const Text('has Description');
    }
    if (data.part!.note != null && data.part!.note!.isNotEmpty) {
      return const Text('has Note');
    }
    return null;
  }

  Future<void> showPartDescription(BuildContext context, String description) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => PartDescriptionDialog(
          description: description,
        )
    );
  }
  
  Future<void> showEditAssignedPartDialog(
    BuildContext context,
    PartToVehiclePart data
  ) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => EditAssignedPartDialog(
          data: data,
          onUpdated: () => refreshState.call(),
          vehiclePart: vehiclePart,
        )
    );
  }

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PopupMenuEntry<ListTileTitleAlignment>> popupMenuItems(PartToVehiclePart data) {
      final items = <PopupMenuEntry<ListTileTitleAlignment>>[];
      final repository = ref.read(partsToVehiclePartsRepositoryProvider);

      Future<void> handleDelete(int id) async {
        await repository.delete.call(id);
        refreshState.call();
      }

      if (data.part!.description != null && data.part!.description!.isNotEmpty) {
        items.add(
            PopupMenuItem(
              onTap: () => showPartDescription.call(context, data.part!.description!),
              child: const Text('Description'),
            )
        );
      }

      items.add(PopupMenuItem(
        onTap: () => showEditAssignedPartDialog(context, data),
        child: const Text('Edit')
      ));
      items.add(PopupMenuItem(
        onTap: () => handleDelete.call(data.id!),
        child: const Text('Delete')
      ));

      return items;
    }

    if (list.isEmpty) {
      return const Text('No parts yet.');
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        final data = list[index];
        
        return ListTile(
          dense: true,
          title: titleBuilder(data),
          trailing: PopupMenuButton<ListTileTitleAlignment>(
            itemBuilder: (BuildContext context) =>
              popupMenuItems(data)
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}