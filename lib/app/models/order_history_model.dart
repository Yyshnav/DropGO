class OrderHistoryItem {
  final int id;
  final String restaurantName;
  final String pickupAddress;
  final String deliveryAddress;
  final List<OrderItem> items;
  final String orderStatus;
  final String paymentStatus;
  final String receivedTime;
  final String deliveredTime;
  final double totalAmount;

  OrderHistoryItem({
    required this.id,
    required this.restaurantName,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.items,
    required this.orderStatus,
    required this.paymentStatus,
    required this.receivedTime,
    required this.deliveredTime,
    required this.totalAmount,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    final orderItemsRaw = (json['order_item'] ?? []) as List;
    final itemsList = orderItemsRaw
        .map((e) => OrderItem.fromJson(e))
        .toList();

    return OrderHistoryItem(
      id: json['id'] ?? 0,
      restaurantName: json['branch']?['name'] ?? "Unknown Branch",
      pickupAddress: json['branch']?['address'] ?? "Unknown Address",
      deliveryAddress: json['delivery_details']?['address']?['address'] ?? "Unknown Delivery",
      items: itemsList,
      orderStatus: json['orderstatus'] ?? "PENDING",
      paymentStatus: json['paymentstatus'] ?? "PENDING",
      receivedTime: json['created_at'] ?? "--:--",
      deliveredTime: json['updated_at'] ?? "--:--",
      totalAmount: (json['totalamount'] ?? 0).toDouble(),
    );
  }
}

class OrderItem {
  final String name;
  final String quantity;

  OrderItem({
    required this.name,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final itemname = json['itemname'] ?? {};
    return OrderItem(
      name: itemname['name'] ?? "Item",
      quantity: json['quantity']?.toString() ?? "1",
    );
  }

  @override
  String toString() => "$name × $quantity";
}
