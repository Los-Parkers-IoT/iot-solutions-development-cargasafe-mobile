enum VehicleStatus { IN_SERVICE, OUT_OF_SERVICE, MAINTENANCE, RETIRED }

VehicleStatus parseVehicleStatus(String s) =>
    VehicleStatus.values.firstWhere(
          (e) => e.name == s.trim().toUpperCase(),
      orElse: () => VehicleStatus.IN_SERVICE,
    );
