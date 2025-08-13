// class  DeliveryOrder {
//   final String orderId;

//   final double? pickupLat;
//   final double? pickupLng;
//   final String pickupAddress;
//   final String pickupLocationName;
//   final String pickupLocationSubtitle;
//   final String pickupLocationFullAddress;

//   final double? deliveryLat;
//   final double? deliveryLng;
//   final String deliveryAddress;
//   final String deliveryPhone;
//   final String deliveryLocationName;
//   final String deliveryLocationSubtitle;
//   final String deliveryLocationFullAddress;

//   DeliveryOrder({
//     required this.orderId,
//     required this.pickupLat,
//     required this.pickupLng,
//     required this.pickupAddress,
//     required this.pickupLocationName,
//     required this.pickupLocationSubtitle,
//     required this.pickupLocationFullAddress,
//     required this.deliveryLat,
//     required this.deliveryLng,
//     required this.deliveryAddress,
//     required this.deliveryPhone,
//     required this.deliveryLocationName,
//     required this.deliveryLocationSubtitle,
//     required this.deliveryLocationFullAddress,
//   });

// factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
//   final branch = json['branch'] ?? {};
//   final delivery = json['delivery_details'] ?? {};
//   final address = delivery['address'] ?? {};

//   return DeliveryOrder(
//     orderId: json['id'].toString(),
    
//     pickupLat: double.tryParse(branch['latitude']?.toString() ?? ''),
//     pickupLng: double.tryParse(branch['longitude']?.toString() ?? ''),
//     pickupAddress: branch['address'] ?? 'Address Not Available',
//     pickupLocationName: branch['name'] ?? 'Pickup Location',
//     pickupLocationSubtitle: branch['place'] ?? 'Pickup Subtitle',
//     pickupLocationFullAddress: branch['address'] ?? 'Address Not Available',

//     deliveryLat: double.tryParse(address['latitude']?.toString() ?? ''),
//     deliveryLng: double.tryParse(address['longitude']?.toString() ?? ''),
//     deliveryAddress: branch['address']['address'] ?? 'Delivery Address Not Available',
//     deliveryPhone: delivery['phone']?.toString() ?? '',
//     deliveryLocationName: branch['address']['address'] ?? 'Delivery Location',
//     deliveryLocationSubtitle: address['place']?.toString() 
//         ?? address['city']?.toString() 
//         ?? 'Delivery Area',
//     deliveryLocationFullAddress: address['address']?.toString() ?? '',
//   );
// }}



// //   factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
// //   final branch = json['branch'] ?? {};
// //   final delivery = json['delivery_details'] ?? {};
// //   final address = delivery['address'] ?? {};

// //   return DeliveryOrder(
// //     orderId: json['id'].toString(),
// //     pickupLat: double.tryParse(branch['latitude']?.toString() ?? '') ?? 0.0,
// //     pickupLng: double.tryParse(branch['longitude']?.toString() ?? '') ?? 0.0,
// //     pickupAddress: branch['address'] ?? 'null',
// //     pickupLocationName: branch['name'] ?? 'Pickup Location',
// //     pickupLocationSubtitle: branch['place'] ?? 'Pickup Subtitle',
// //     pickupLocationFullAddress: branch['address'] ?? 'null',

// //     deliveryLat: double.tryParse(address['latitude']?.toString() ?? '') ?? 0.0,
// //     deliveryLng: double.tryParse(address['longitude']?.toString() ?? '') ?? 0.0,
// //     deliveryAddress: address['address'] ?? 'Delivery Address Not Available',
// //     deliveryPhone: delivery['phone']?.toString() ?? '',
// //     deliveryLocationName: address['address'] ?? 'Delivery Location',
// //     deliveryLocationSubtitle: address['place']?.toString() 
// //         ?? address['city']?.toString() 
// //         ?? 'Delivery Area',
// //     deliveryLocationFullAddress: address['address']?.toString() ?? '',
// //   );
// // }

class DeliveryOrder {
  final String orderId;
  final double? pickupLat;
  final double? pickupLng;
  final String pickupAddress;
  final String pickupLocationName;
  final String pickupLocationSubtitle;
  final String pickupLocationFullAddress;
  final double? deliveryLat;
  final double? deliveryLng;
  final String deliveryAddress;
  final String deliveryPhone;
  final String deliveryLocationName;
  final String deliveryLocationSubtitle;
  final String deliveryLocationFullAddress;

  DeliveryOrder({
    required this.orderId,
    this.pickupLat,
    this.pickupLng,
    required this.pickupAddress,
    required this.pickupLocationName,
    required this.pickupLocationSubtitle,
    required this.pickupLocationFullAddress,
    this.deliveryLat,
    this.deliveryLng,
    required this.deliveryAddress,
    required this.deliveryPhone,
    required this.deliveryLocationName,
    required this.deliveryLocationSubtitle,
    required this.deliveryLocationFullAddress,
  });

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    final branch = json['branch'] ?? {};
    final address = json['address'] ?? {};

    return DeliveryOrder(
      orderId: json['id']?.toString() ?? '',
      pickupLat: double.tryParse(branch['latitude']?.toString() ?? ''),
      pickupLng: double.tryParse(branch['longitude']?.toString() ?? ''),
      pickupAddress: branch['address']?.toString() ?? 'Address Not Available',
      pickupLocationName: branch['name']?.toString() ?? 'Pickup Location',
      pickupLocationSubtitle: branch['place']?.toString() ?? 'Pickup Subtitle',
      pickupLocationFullAddress: branch['address']?.toString() ?? 'Address Not Available',
      deliveryLat: double.tryParse(address['latitude']?.toString() ?? '') ?? double.tryParse(json['latitude']?.toString() ?? ''),
      deliveryLng: double.tryParse(address['longitude']?.toString() ?? '') ?? double.tryParse(json['longitude']?.toString() ?? ''),
      deliveryAddress: address['address']?.toString() ?? 'Delivery Address Not Available',
      deliveryPhone: address['phone']?.toString() ?? json['phone_number']?.toString() ?? '',
      deliveryLocationName: address['address']?.toString() ?? 'Delivery Location',
      deliveryLocationSubtitle: address['city']?.toString() ?? 'Delivery Area',
      deliveryLocationFullAddress: address['address']?.toString() ?? '',
    );
  }
}