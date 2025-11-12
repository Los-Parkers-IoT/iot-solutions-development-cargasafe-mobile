enum VehicleType { TRUCK, VAN, CAR, MOTORCYCLE }

VehicleType parseVehicleType(String s) =>
    VehicleType.values.firstWhere(
          (e) => e.name == s.trim().toUpperCase(),
      orElse: () => VehicleType.TRUCK,
    );
