import 'package:cargasafe/trips/domain/model/origin_point.dart';
import 'package:cargasafe/trips/infrastructure/origin_point_response.dart';

class OriginPointAssembler {
  static List<OriginPoint> fromResources(List<OriginPointResponse> resources) {
    return resources.map(fromResource).toList();
  }

  static OriginPoint fromResource(OriginPointResponse resource) {
    return OriginPoint(
      id: resource.id,
      name: resource.name,
      address: resource.address,
      latitude: resource.latitude,
      longitude: resource.longitude,
    );
  }
}
