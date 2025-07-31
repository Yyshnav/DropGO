import 'package:audioplayers/audioplayers.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/constants/payment_slider.dart';
import 'package:dropgo/app/controllers/order_location_controller.dart';
import 'package:dropgo/app/controllers/orderdetails_controller.dart';
import 'package:dropgo/app/models/order_datail_model.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:get/get.dart';


class DetailedOrderPage extends StatelessWidget {
  final String orderId;
  DetailedOrderPage({super.key, required this.orderId});
  final controller = Get.put(OrderLocationController());
  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // final String orderId = ''; 
    orderController.fetchOrderDetails(orderId);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Order Details'.tr,
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),       
        ),
        backgroundColor: AppColors.cardbgclr,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final order = orderController.order.value;
        if (order == null) {
          return const Center(child: Text("No order details available"));
        }
  //       controller.setPickupAndDrop(
  //   LatLng(order.pickupLatitude, order.pickupLongitude),
  //   LatLng(order.deliveryLatitude, order.deliveryLongitude),
  // );

        // final order = controller.deliveryOrder.value!;
 return Stack(
    children: [
      Obx(() {
  return GoogleMap(
    initialCameraPosition: CameraPosition(
      target: controller.currentPosition.value,
      zoom: 14.0,
    ),
    myLocationEnabled: true,
    onMapCreated: controller.setMapController,
    markers: controller.markers,
    polylines: controller.routePolyline,
  );
}),
      DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.2,
        maxChildSize: 0.65,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: OrderDetailsPage(scrollController: scrollController, order: order),
          );
        },
      ),
    ],
  );
}),
    );
  }}

class OrderDetailsPage extends StatelessWidget {
  final ScrollController scrollController;
  final OrderDetailModel order;
  OrderDetailsPage({super.key, required this.scrollController, required this.order});

  final orderController = Get.put(OrderController());
  final AudioPlayer audioPlayer = AudioPlayer();
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  final String voiceNoteUrl =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  final String deliveryNote =
      "Please leave the parcel at the reception if I’m not available.";

  final RxBool isPaymentDone = false.obs;    

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.black54;
    // final bgColor = isDark ? Colors.black : AppColors.lightyellowBg;
    final cardColor = isDark ? Colors.grey[900] : Colors.white;

    return 
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Divider(),
              Responsive.h(context, 3),
          
              // User Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/bgimage.png',
                      fit: BoxFit.fill,
                      height: 40,
                      width: 40,
                    ),
                  ),
          
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "124 Deliveries".tr,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemPadding: const EdgeInsets.only(right: 4),
                              rating: 4.1,
                              itemBuilder: (context, index) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 18.0,
                              direction: Axis.horizontal,
                            ),
                            const Text('4.1', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFFFEEBDB),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/call.png',
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                      Responsive.w(context, 5),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFFFEEBDB),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/chat.png',
                            height: 16,
                            width: 16,
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.chat, arguments: order.orderId);
                          },
                        ),
                      ),
                      Responsive.w(context, 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.lightStatus,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            'Pending'.tr,
                            style: TextStyle(
                              color: AppColors.lightyellowBg,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          
              Responsive.h(context, 7),
          
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/pickup.png',
                        height: 20,
                        width: 20,
                      ),
                      Responsive.h(context, 1),
                      Icon(Icons.circle, size: 8, color: const Color(0xFF28B877)),
                      Responsive.h(context, 0.7),
                      Icon(Icons.circle, size: 8, color: const Color(0xFF28B877)),
                      Responsive.h(context, 0.7),
                      Icon(Icons.circle, size: 8, color: const Color(0xFF28B877)),
                      Responsive.h(context, 1),
                      Image.asset(
                        'assets/images/drop.png',
                        height: 15,
                        width: 15,
                      ),
                    ],
                  ),
                  Responsive.w(context, 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup Location".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      Responsive.h(context, 1),
                      Text(
                        // "Bombay Hotel Kozhikode",
                        order.pickupLocation,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
          
                      Responsive.h(context, 2),
          
                      Text(
                        "Delivery Location".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      Responsive.h(context, 1),
                      Text(
                        // "Trycode Innovations Kozhikode",
                        order.deliveryLocation,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          
              Responsive.h(context, 5),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Items to be picked".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    "Customer contact number".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 8),
              Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // LEFT: Items list
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (order.items as List)
            .map<Widget>((dynamic raw) {
              final Map<String, dynamic> item = raw as Map<String, dynamic>;

              final name = (item['name'] ?? 'Item').toString();
              final qty  = int.tryParse(item['quantity']?.toString() ?? '1') ?? 1;

              // Some payloads nest product data, eg: item['product']['name']
              // If you need that, fallback:
              final product = item['product'] as Map<String, dynamic>?; 
              final displayName = product?['name']?.toString() ?? name;

              // Image: look for `image` or `product.image`
              String? imageUrl;
              if (item['image'] != null && item['image'].toString().isNotEmpty) {
                imageUrl = item['image'].toString();
              } else if (product?['image'] != null && product!['image'].toString().isNotEmpty) {
                imageUrl = product['image'].toString();
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "$displayName × $qty",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Responsive.w(Get.context!, 4),
                    if (imageUrl != null)
                      Image.network(
                        imageUrl,
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/food.png',
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Image.asset(
                        'assets/images/food.png',
                        height: 24,
                        width: 24,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              );
            })
            .toList(),
      ),
    ),

    // RIGHT: Customer phone
    Text(
      _formatPhone(order.customerPhone),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(Get.context!).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    ),
  ],
),

                  Responsive.h(context, 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: subtitleColor,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: subtitleColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "COD",
                        order.paymentMethod,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: subtitleColor,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        // "₹150",
                        "₹${order.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  // Obx(() => PaymentConfirmationSlider(isPaymentConfirmed: isPaymentDone)),
                   Obx(() {
              final isPaymentConfirmed = orderController.isPaymentConfirmed.value;
              final selectedPaymentType = orderController.selectedPaymentType.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: Text(
                      "Payment Delivered",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    activeColor: Colors.green,
                    value: isPaymentConfirmed,
                    onChanged: (value) {
                      orderController.isPaymentConfirmed.value = value;
                      if (!value) orderController.selectedPaymentType.value = "";
                    },
                  ),
                  if (isPaymentConfirmed) ...[
                    const SizedBox(height: 8),
                    Text("Select Payment Type",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPaymentOption("CASH", selectedPaymentType),
                        _buildPaymentOption("ONLINE", selectedPaymentType),
                      ],
                    ),
                  ],
                ],
              );
            }),
                  if (voiceNoteUrl.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.record_voice_over, color: subtitleColor),
                          const SizedBox(width: 8),
                          Text(
                            "Delivery Instructions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const Spacer(),
                          ValueListenableBuilder<bool>(
                            valueListenable: isPlaying,
                            builder: (context, playing, _) {
                              return IconButton(
                                icon: Icon(
                                  playing
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                                onPressed: () async {
                                  if (playing) {
                                    await audioPlayer.pause();
                                  } else {
                                    await audioPlayer.play(
                                      UrlSource(voiceNoteUrl),
                                    );
                                  }
                                  isPlaying.value = !playing;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    if ((order.customerNote ?? '').isNotEmpty)
  Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.notes, color: subtitleColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Customer Note",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  order.customerNote ?? 'No additional note provided.',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),

                  Responsive.h(context, 5),
                  Obx(() {
                    final isPaymentConfirmed = orderController.isPaymentConfirmed.value;
              final selectedPaymentType = orderController.selectedPaymentType.value;
                    if (orderController.isDelivered.value) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        child: Text(
                          "Order Delivered ✅",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else if (!orderController.isPickedUp.value) {
                      return SlideAction(
                        text: "Slide to Confirm Pickup",
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        outerColor: AppColors.primary,
                        innerColor: AppColors.lightyellowBg,
                        onSubmit: () async{
                          // orderController.confirmPickup();
                          // await orderController.updateStatus(order.orderId, "picked_up");
                          await orderController.updateStatus("OUT_FOR_DELIVERY");

                          return null;
                        },
                      );
                    } else {
                      return SlideAction(
                        text: "Slide to Deliver Order",
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        outerColor: (isPaymentConfirmed && selectedPaymentType.isNotEmpty)
                    ? AppColors.primary
                    : Colors.grey,
                        // outerColor: AppColors.primary,
                        innerColor: AppColors.lightyellowBg,
                        onSubmit: () async{
                          // orderController.deliverOrder();
                          // await orderController.updateStatus("DELIVERED");

                          // Get.offAndToNamed(AppRoutes.success);
                          // return null;
                          if (!isPaymentConfirmed || selectedPaymentType.isEmpty) {
                    Get.snackbar("Payment Required", "Confirm payment before delivering");
                    return null;
                  }
                  await orderController.updateStatus(
                    "DELIVERED",
                    paymentDone: true,
                    paymentType: orderController.selectedPaymentType.value,
                  );
                  Get.offAndToNamed(AppRoutes.success);
                  return null;
                },
                      );
                    }
                  }),
                  const SizedBox(height: 16),
           
              Responsive.h(context, 5),
  
            ],
          ),
        ),
      );

          // );   
    
  }
  Widget _buildPaymentOption(String type, String selectedType) {
    final isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => orderController.selectedPaymentType.value = type,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  String _formatPhone(String? raw) {
  if (raw == null || raw.isEmpty) return "-";
  // Example naive formatting: ensure +91 prefix if 10 digits
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.length == 10) return "+91 $digits";
  return raw;
}
}
