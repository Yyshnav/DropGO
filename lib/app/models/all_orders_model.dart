class OrderModel {
  final String id;
  final DateTime createdAt;
  final String status; // e.g. "PENDING", "IN_PROGRESS", etc.

  // pickup (restaurant / branch)
  final String pickupName;
  final String pickupCity;
  final double pickupLat;
  final double pickupLng;

  // drop (customer)
  final String dropName;
  final String dropCity;
  final double dropLat;
  final double dropLng;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.pickupName,
    required this.pickupCity,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropName,
    required this.dropCity,
    required this.dropLat,
    required this.dropLng,
  });

  /// Build from the backend JSON you showed earlier.
  /// Adjust keys if your payload differs.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final branch = json['branch'] ?? {};
    final deliveryDetails = json['delivery_details'] ?? {};
    final deliveryAddr = deliveryDetails['address'] ?? {};

    return OrderModel(
      id: json['id']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      status: (json['orderstatus'] ?? '').toString(),

      pickupName: branch['name']?.toString() ?? '',
      pickupCity: branch['place']?.toString() ?? '',
      pickupLat: double.tryParse(branch['latitude']?.toString() ?? '') ?? 0.0,
      pickupLng: double.tryParse(branch['longitude']?.toString() ?? '') ?? 0.0,

      dropName: deliveryDetails['name']?.toString() ?? '',
      dropCity: deliveryAddr['city']?.toString() ?? '',
      dropLat: double.tryParse(deliveryAddr['latitude']?.toString() ?? '') ?? 0.0,
      dropLng: double.tryParse(deliveryAddr['longitude']?.toString() ?? '') ?? 0.0,
    );
  }
}
