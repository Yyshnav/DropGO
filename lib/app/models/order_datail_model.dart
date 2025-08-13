// class OrderDetailModel {
//   final String orderId;
//   String status;
//   final String customerName;
//   final String pickupLocation;
//   final String deliveryLocation;
//   final String customerPhone;
//   final double amount;
//   final String paymentMethod;
//   final List<Map<String, dynamic>> items; // [{'name': 'Biriyani', 'qty': 1}]
//   final String voiceNoteUrl;
//   final String customerNote;
//   final double rating;

//   OrderDetailModel({
//     required this.orderId,
//     required this.status,
//     required this.customerName,
//     required this.pickupLocation,
//     required this.deliveryLocation,
//     required this.customerPhone,
//     required this.amount,
//     required this.paymentMethod,
//     required this.items,
//     required this.voiceNoteUrl,
//     required this.customerNote,
//     required this.rating,
//   });

//   factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailModel(
//       orderId: json['orderId'],
//       status: json["status"],
//       customerName: json['customerName'],
//       pickupLocation: json['pickupLocation'],
//       deliveryLocation: json['deliveryLocation'],
//       customerPhone: json['customerPhone'],
//       amount: (json['amount'] as num).toDouble(),
//       paymentMethod: json['paymentMethod'],
//       items: List<Map<String, dynamic>>.from(json['items']),
//       voiceNoteUrl: json['voiceNoteUrl'] ?? '',
//       customerNote: json['customerNote'] ?? '',
//       rating: (json['rating'] as num).toDouble(),
//     );
//   }
// }

class OrderDetailModel {
  final String orderId;
  String status;
  final String customerName;
  final String pickupLocation;
  final String deliveryLocation;
  final String customerPhone;
  final double amount;
  final String paymentMethod;
  final List<Map<String, dynamic>> items;
  final String customerNote;

  final double pickupLatitude;
  final double pickupLongitude;
  final double deliveryLatitude;
  final double deliveryLongitude;

  OrderDetailModel({
    required this.orderId,
    required this.status,
    required this.customerName,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.customerPhone,
    required this.amount,
    required this.paymentMethod,
    required this.items,
    required this.customerNote,

    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
  final branch = json['branch'] ?? {};
  final deliveryDetails = json['delivery_details'] ?? {};
  final deliveryAddr = deliveryDetails['address'] ?? {};

  // Parse items
  final List<Map<String, dynamic>> parsedItems =
      (json['order_item'] as List?)?.map((item) {
            final itemName = item['itemname'] ?? {};
            return {
              'name': itemName['name']?.toString() ?? 'Item',
              'quantity': int.tryParse(item['quantity']?.toString() ?? '1') ?? 1,
              'price': double.tryParse(item['price']?.toString() ?? '0') ?? 0.0,
            };
          }).toList() ?? [];

  return OrderDetailModel(
    orderId: json['id']?.toString() ?? '',
    status: json['orderstatus']?.toString() ?? 'UNKNOWN',
    customerName: deliveryDetails['name']?.toString() ?? 'Customer',
    pickupLocation: branch['address']?.toString() ?? 'Unknown Pickup Location',
    deliveryLocation: deliveryAddr['address']?.toString() ?? 'Unknown Delivery Location',
    customerPhone: deliveryDetails['phone']?.toString() ?? '',
    amount: double.tryParse(json['totalamount']?.toString() ?? '0') ?? 0.0,
    paymentMethod: json['payment_method']?.toString() ?? 'UNKNOWN',
    items: parsedItems,
    customerNote: deliveryDetails['instruction']?.toString() ?? '',
    pickupLatitude: double.tryParse(branch['latitude']?.toString() ?? '0') ?? 0.0,
    pickupLongitude: double.tryParse(branch['longitude']?.toString() ?? '0') ?? 0.0,
    deliveryLatitude: double.tryParse(deliveryAddr['latitude']?.toString() ?? '0') ?? 0.0,
    deliveryLongitude: double.tryParse(deliveryAddr['longitude']?.toString() ?? '0') ?? 0.0,
  );
}
}
