// class OrderModel {
//   final String id;
//   final DateTime createdAt;
//   final String status; // e.g. "PENDING", "IN_PROGRESS", etc.

//   // pickup (restaurant / branch)
//   final String pickupName;
//   final String pickupCity;
//   final double pickupLat;
//   final double pickupLng;

//   // drop (customer)
//   final String dropName;
//   final String dropCity;
//   final double dropLat;
//   final double dropLng;

//   OrderModel({
//     required this.id,
//     required this.createdAt,
//     required this.status,
//     required this.pickupName,
//     required this.pickupCity,
//     required this.pickupLat,
//     required this.pickupLng,
//     required this.dropName,
//     required this.dropCity,
//     required this.dropLat,
//     required this.dropLng,
//   });

//   /// Build from the backend JSON you showed earlier.
//   /// Adjust keys if your payload differs.
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     final branch = json['branch'] ?? {};
//     final deliveryDetails = json['delivery_details'] ?? {};
//     final deliveryAddr = deliveryDetails['address'] ?? {};

//     return OrderModel(
//       id: json['id']?.toString() ?? '',
//       createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
//       status: (json['orderstatus'] ?? '').toString(),

//       pickupName: branch['name']?.toString() ?? '',
//       pickupCity: branch['place']?.toString() ?? '',
//       pickupLat: double.tryParse(branch['latitude']?.toString() ?? '') ?? 0.0,
//       pickupLng: double.tryParse(branch['longitude']?.toString() ?? '') ?? 0.0,

//       dropName: deliveryDetails['name']?.toString() ?? '',
//       dropCity: deliveryAddr['city']?.toString() ?? '',
//       dropLat: double.tryParse(deliveryAddr['latitude']?.toString() ?? '') ?? 0.0,
//       dropLng: double.tryParse(deliveryAddr['longitude']?.toString() ?? '') ?? 0.0,
//     );
//   }
// }

class OrderModel {
  final String id;
  final DateTime createdAt;
  final String status;
  final String pickupName;
  final String pickupCity;
  final double? pickupLat;
  final double? pickupLng;
  final String dropName;
  final String dropCity;
  final double? dropLat;
  final double? dropLng;
  final String phoneNumber;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.pickupName,
    required this.pickupCity,
    this.pickupLat,
    this.pickupLng,
    required this.dropName,
    required this.dropCity,
    this.dropLat,
    this.dropLng,
    required this.phoneNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final branch = json['branch'] ?? {};
    final address = json['address'] ?? {};
    final deliveryDetails = json['delivery_details'] ?? {};
    String fullAddress = address['address']?.toString() ?? 'Unknown Address';
    String trimmedAddress = fullAddress;
    if (fullAddress.isNotEmpty) {
      final parts = fullAddress.split(', ');
      // Find the index of the city (e.g., "Kozhikode") or postal code (e.g., "673004")
      int endIndex = parts.length;
      for (int i = 0; i < parts.length; i++) {
        // Check for postal code (simple regex for 6-digit codes)
        if (RegExp(r'^\d{6}$').hasMatch(parts[i]) || parts[i].toLowerCase().contains(address['city']?.toString().toLowerCase() ?? '')) {
          endIndex = i;
          break;
        }
      }
      // Keep parts up to the last street/locality before city or postal code
      trimmedAddress = parts.sublist(0, endIndex).join(', ');
    }

    return OrderModel(
      id: json['id']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      status: json['orderstatus']?.toString() ?? 'UNKNOWN',
      pickupName: branch['address']?.toString() ?? 'Unknown Pickup',
      pickupCity: branch['place']?.toString() ?? 'Unknown City',
      pickupLat: double.tryParse(branch['latitude']?.toString() ?? ''),
      pickupLng: double.tryParse(branch['longitude']?.toString() ?? ''),
      dropName: trimmedAddress,
      // address['address']?.toString() ?? address['name']?.toString() ?? 'Unknown Delivery',
      dropCity: address['city']?.toString() ?? 'Unknown City',
      dropLat: double.tryParse(address['latitude']?.toString() ?? '') ?? double.tryParse(json['latitude']?.toString() ?? ''),
      dropLng: double.tryParse(address['longitude']?.toString() ?? '') ?? double.tryParse(json['longitude']?.toString() ?? ''),
      phoneNumber: json['phone_number']?.toString() ?? address['phone']?.toString() ?? '',
    );
  }
}