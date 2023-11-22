import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/vehicle_detail_body.dart';
import '../stores/vehicles.dart';
import 'create_vehicle_part.dart';
import 'vehicle_edit.dart';
import '../widgets/floating_create_button.dart';
import '../widgets/floating_search_bar.dart';
import '../widgets/refresh_button.dart';
import '../widgets/vehicle_part_list.dart';
import '../widgets/detail_action_buttons.dart';
import '../types/vehicle_part.dart';
import '../types/vehicle_detail.dart';

class VehicleDetailScreen extends ConsumerStatefulWidget {
  const VehicleDetailScreen({
    super.key,
    required this.vehicleId
  });

  final int vehicleId;

  @override
  ConsumerState<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends ConsumerState<VehicleDetailScreen> {
  late Future<VehicleDetail> _vehicleDetail;

  @override
  void initState() {
    super.initState();

    _vehicleDetail = _getVehicleDetail();
  }

  Future<VehicleDetail> _getVehicleDetail() {
    final vehiclesRepository = ref.read(vehiclesRepositoryProvider);

    return vehiclesRepository.get(widget.vehicleId);
  }

  void _refreshVehicleDetail() {
    if (!mounted) return;
    setState(() {
      _vehicleDetail = _getVehicleDetail();
    });
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _vehicleDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final vehicle = snapshot.data!;

            return VehicleDetailScreenScaffold(
              vehicleDetail: vehicle,
              refreshState: _refreshVehicleDetail,
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: RefreshButton(
                  onPressed: () {
                    if (!mounted) return;
                    setState(() {

                    });
                  },
                ),
              )
            );
          } else {
            return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                )
            );
          }
        }
    );
  }
}

class VehicleDetailScreenScaffold extends ConsumerStatefulWidget {
  const VehicleDetailScreenScaffold({
    super.key,
    required this.vehicleDetail,
    required this.refreshState
  });

  final VehicleDetail vehicleDetail;
  final Function() refreshState;

  @override
  ConsumerState<VehicleDetailScreenScaffold> createState() => _VehicleDetailScreenScaffoldState();
}

class _VehicleDetailScreenScaffoldState extends ConsumerState<VehicleDetailScreenScaffold> {
  final partSearchController = TextEditingController();
  List<VehiclePart> filteredVehicleParts = [];

  @override
  void initState() {
    super.initState();

    partSearchController.addListener(refreshVehicleParts);

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) { refreshVehicleParts(); });
  }

  @override
  void dispose() {
    partSearchController.dispose();

    super.dispose();
  }

  Future<void> _delete() async {
    final vehiclesRepository = ref.read(vehiclesRepositoryProvider);

    try {
      await vehiclesRepository.delete(widget.vehicleDetail.id!);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  void refreshVehicleParts() {
    final keywords = partSearchController.text.trim().split(' ');
    final vehicleParts = widget.vehicleDetail.vehicleParts ?? [];

    Iterable<VehiclePart> whereQuery = vehicleParts;

    for (final word in keywords) {
      whereQuery = whereQuery.where((e) => e.name.toLowerCase().contains(word.toLowerCase()));
    }

    widget.refreshState.call();

    if (!mounted) return;
    setState(() {
      filteredVehicleParts = whereQuery.toList();
    });
  }

  void _edit() {
    Navigator.push(
        context, MaterialPageRoute(
      builder: (context) => VehicleEditScreen(vehicleId: widget.vehicleDetail.id!),
      maintainState: false,
    )
    ).then((_) {
      if (!mounted) return;
      setState(() { });
    });
  }

  void _createVehiclePart(VehicleDetail vehicleDetail) {
    Navigator.push(
      context, MaterialPageRoute(
      builder: (context) => CreateVehiclePartScreen(vehicle: vehicleDetail,),
      maintainState: false,
    ),
    ).then((_) {
      if (!mounted) return;
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Detail'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  VehicleDetailBody(
                    name: widget.vehicleDetail.name,
                    description: widget.vehicleDetail.description,
                    note: widget.vehicleDetail.note,
                  ),
                  const SizedBox(height: 16,),
                  DetailActionButtons(handleDelete: _delete, handleEdit: _edit),
                  const SizedBox(height: 16,),
                  FloatingSearchBar(searchController: partSearchController),
                  Card(
                      margin: const EdgeInsets.only(top: 16),
                      child: Column(
                        children: [
                          generateSpacer('Start of Parts'),
                          Row(
                            children: [
                              Expanded(
                                  child: VehiclePartList(
                                    vehicleParts: filteredVehicleParts,
                                    refreshState: () => refreshVehicleParts.call(),
                                  )
                              )
                            ],
                          ),
                          generateSpacer('End of Parts'),
                        ],
                      )
                  )
                ],
              )
          )
      ),
      floatingActionButton: FloatingCreateButton(
        onTapHandler: () => _createVehiclePart(widget.vehicleDetail),
      ),
    );
  }
}