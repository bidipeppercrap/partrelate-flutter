import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/floating_create_button.dart';
import '../widgets/floating_search_bar.dart';
import '../widgets/refresh_button.dart';
import '../widgets/vehicle_list.dart';
import '../widgets/pagination.dart';
import 'create_vehicle.dart';
import 'vehicle_detail.dart';
import '../widgets/padbox.dart';
import '../stores/vehicles.dart';

class VehiclesScreen extends ConsumerStatefulWidget {
  const VehiclesScreen({super.key});

  @override
  ConsumerState<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends ConsumerState<VehiclesScreen> {
  final searchController = TextEditingController();
  String searchText = '';
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    searchController.addListener(handleSearchChange);
  }

  void handleSearchChange() {
    setState(() {
      searchText = searchController.text;
      currentPage = 1;
    });
  }

  void handleNext() {
    setState(() {
      currentPage++;
      searchText = searchController.text;
    });
  }

  void handlePrev() {
    setState(() {
      currentPage--;
      searchText = searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  void _createVehicle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateVehicleScreen(),
        maintainState: false,
      ),
    ).then((_) {
      if (!mounted) return;
      setState(() { });
    });
  }

  void _vehicleDetail(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleDetailScreen(vehicleId: id,),
        maintainState: false,
      ),
    ).then((_) {
      if (!mounted) return;
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesRepository = ref.read(vehiclesRepositoryProvider);
    final vehicles = vehiclesRepository.fetch(searchText, currentPage);

    return Stack(
      children: [
        FutureBuilder(
            future: vehicles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const PadBox(title: ''),
                      const PadBox(title: 'Start of Vehicles'),
                      VehicleList(
                        vehicles: snapshot.data!.data,
                        onTapHandler: _vehicleDetail,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Pagination(
                          totalPages: snapshot.data!.totalPages,
                          currentPage: currentPage,
                          handleNext: handleNext,
                          handlePrev: handlePrev,
                        )
                      ),
                      const PadBox(title: 'End of Vehicles'),
                    ],
                  )
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: RefreshButton(
                    onPressed: () {
                      setState(() { });
                    },
                  )
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        ),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: FloatingSearchBar(searchController: searchController,),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingCreateButton(onTapHandler: () => _createVehicle(),),
        ),
      ],
    );
  }
}