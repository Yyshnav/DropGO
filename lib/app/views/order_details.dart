import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/orderdetails_controller.dart';

import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({super.key});

  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightyellowBg,
      appBar: AppBar(
        toolbarHeight: 70,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      const Text(
                        "Shabna",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "124 Deliveries",
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
                        onPressed: () {},
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
                          'Pending',
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
                      "Pickup Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    Responsive.h(context, 1),
                    Text(
                      "Bombay Hotel Kozhikode",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),

                    Responsive.h(context, 2),

                    Text(
                      "Delivery Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    Responsive.h(context, 1),
                    Text(
                      "Trycode Innovations Kozhikode",
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

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items to be picked",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Customer contact number",
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Biriyani × 1"),
                          Responsive.w(context, 4),
                          Image.asset(
                            'assets/images/food.png',
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                      Responsive.h(context, 1),
                      Row(
                        children: [
                          Text("Alfahm Mandhi × 1"),
                          Responsive.w(context, 4),
                          Image.asset(
                            'assets/images/food.png',
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                      Responsive.h(context, 1),
                      Row(
                        children: [
                          Text("Pepsi 500ml × 1"),
                          Responsive.w(context, 4),
                          Image.asset(
                            'assets/images/food.png',
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text(
                  "+91 123456789",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Responsive.h(context, 5),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "Amount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "COD",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "₹150",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),

            const Spacer(),
            Obx(() {
              if (orderController.isDelivered.value) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  child: const Text(
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
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  outerColor: AppColors.primary,
                  innerColor: AppColors.lightyellowBg,
                  onSubmit: () {
                    orderController.confirmPickup();
                    return null;
                  },
                );
              } else {
                return SlideAction(
                  text: "Slide to Deliver Order",
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  outerColor: AppColors.primary,
                  innerColor: AppColors.lightyellowBg,
                  onSubmit: () {
                    orderController.deliverOrder();
                    Get.offAndToNamed(AppRoutes.success);
                    return null;
                  },
                );
              }
            }),

            // // Buttons
            // ElevatedButton(
            //   onPressed: () {
            //     // Call your pickup logic via controller if needed
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50),
            //     backgroundColor: AppColors.primary,
            //     foregroundColor: AppColors.lightyellowBg,

            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //   ),
            //   child: const Text("Confirm Pickup", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
            // ),
            // const SizedBox(height: 12),
            // ElevatedButton(
            //   onPressed: () {
            //     // Call your delivery logic via controller if needed
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50),
            //     backgroundColor: AppColors.primary,
            //     foregroundColor: AppColors.lightyellowBg,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //   ),
            //   child: const Text("Order Delivered", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
            // ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
