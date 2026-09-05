// import 'package:dropgo/app/constants/colors.dart';
// import 'package:dropgo/app/controllers/orderhistory_controller.dart';
// import 'package:dropgo/app/models/order_history_model.dart';
// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OrderHistoryScreen extends StatelessWidget {
//   final controller = Get.put(OrderHistoryController());

//   OrderHistoryScreen({super.key});

//   Widget _buildOrderCard(BoxConstraints constraints, OrderHistoryItem order, ThemeData theme) {
//   return Card(
//     color: theme.cardColor,
//     elevation: 2,
//     margin: const EdgeInsets.symmetric(vertical: 10),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     child: Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 order.restaurantName,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: constraints.maxWidth * 0.045,
//                   color: theme.textTheme.bodyLarge?.color,
//                 ),
//               ),
//               Text("3.5km", style: TextStyle(color: theme.hintColor)),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Icon(Icons.location_pin, color: theme.iconTheme.color),
//                   ...List.generate(
//                     6,
//                     (_) => Container(
//                       width: 2,
//                       height: 4,
//                       margin: const EdgeInsets.symmetric(vertical: 1),
//                       color: theme.dividerColor,
//                     ),
//                   ),
//                   Icon(Icons.flag, color: theme.iconTheme.color),
//                 ],
//               ),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: Get.width * 0.7,
//                     child: Text(
//                       order.pickupAddress,
//                       style: TextStyle(
//                         color: theme.textTheme.bodySmall?.color,
//                         fontSize: constraints.maxWidth * 0.035,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     width: Get.width * 0.7,
//                     child: Text(
//                       order.deliveryAddress,
//                       style: TextStyle(
//                         color: theme.textTheme.bodySmall?.color,
//                         fontSize: constraints.maxWidth * 0.035,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Icon(Icons.fastfood, color: theme.iconTheme.color),
//               const SizedBox(width: 5),
//               Expanded(
//                 child: Text(
//                   order.items.map((e) => e.toString()).join(", "),
//                   style: TextStyle(
//                     color: theme.textTheme.bodyMedium?.color,
//                     fontSize: constraints.maxWidth * 0.035,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.access_time, color: theme.iconTheme.color),
//                   const SizedBox(width: 6),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Order Received", style: TextStyle(color: theme.hintColor)),
//                       Text(
//                         order.receivedTime.split("T").last.split(".").first.substring(0, 5),
//                         style: TextStyle(color: theme.textTheme.bodyMedium?.color),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.delivery_dining, color: theme.iconTheme.color),
//                   const SizedBox(width: 6),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Delivery Time", style: TextStyle(color: theme.hintColor)),
//                       Text(
//                         order.deliveredTime.split("T").last.split(".").first.substring(0, 5),
//                         style: TextStyle(color: theme.textTheme.bodyMedium?.color),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               OutlinedButton(
//                   onPressed: () => Get.toNamed(AppRoutes.complaint),
//                   style: OutlinedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     foregroundColor: AppColors.lightBackground,
//                   ),
//                   child: const Text("Complaint"),
//                 ),
//               ElevatedButton(
//                 onPressed: () {

//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 ),
//                 child: Text(order.orderStatus),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text("Order History", style: TextStyle(color: theme.textTheme.titleLarge?.color)),
//         backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
//         elevation: 0,
//         leading: BackButton(color: theme.iconTheme.color),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             return Column(
//               children: [
//                 TabBar(
//                   controller: controller.tabController,
//                   labelColor: AppColors.primary,
//                   unselectedLabelColor: theme.unselectedWidgetColor,
//                   indicatorColor: AppColors.primary,
//                   tabs: const [
//                     Tab(text: "Completed"),
//                     Tab(text: "Cancelled"),
//                   ],
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: controller.tabController,
//                     children: [
//                       controller.completedOrders.isEmpty
//                           ? const Center(child: Text("No completed orders"))
//                           : ListView.builder(
//                               padding: const EdgeInsets.all(16),
//                               itemCount: controller.completedOrders.length,
//                               itemBuilder: (_, i) => _buildOrderCard(
//                                 constraints,
//                                 controller.completedOrders[i],
//                                 theme,
//                               ),
//                             ),
//                       controller.cancelledOrders.isEmpty
//                           ? const Center(child: Text("No cancelled orders"))
//                           : ListView.builder(
//                               padding: const EdgeInsets.all(16),
//                               itemCount: controller.cancelledOrders.length,
//                               itemBuilder: (_, i) => _buildOrderCard(
//                                 constraints,
//                                 controller.cancelledOrders[i],
//                                 theme,
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           });
//         },
//       ),
//     );
//   }
// }


import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/controllers/orderhistory_controller.dart';
import 'package:dropgo/app/models/order_history_model.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatelessWidget {
  final controller = Get.put(OrderHistoryController());

  OrderHistoryScreen({super.key});

  Widget _buildOrderCard(BoxConstraints constraints, OrderHistoryItem order, ThemeData theme) {
    return Card(
      color: theme.cardColor,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant name & distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.restaurantName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth * 0.045,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                Text(order.orderStatus, style: TextStyle(color: AppColors.lightStatus)),
              ],
            ),
            const SizedBox(height: 8),

            // Pickup & delivery addresses
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Icon(Icons.location_pin, color: theme.iconTheme.color),
                    ...List.generate(
                      6,
                      (_) => Container(
                        width: 2,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        color: theme.dividerColor,
                      ),
                    ),
                    Icon(Icons.flag, color: theme.iconTheme.color),
                  ],
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.7,
                      child: Text(
                        order.pickupAddress,
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color,
                          fontSize: constraints.maxWidth * 0.035,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: Get.width * 0.7,
                      child: Text(
                        order.deliveryAddress,
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color,
                          fontSize: constraints.maxWidth * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Items
            Row(
              children: [
                Icon(Icons.fastfood, color: theme.iconTheme.color),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    order.items.map((e) => e.toString()).join(", "),
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: constraints.maxWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Times
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: theme.iconTheme.color),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order Received", style: TextStyle(color: theme.hintColor)),
                        Text(
                          order.receivedTime.split("T").last.split(".").first.substring(0, 5),
                          style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.delivery_dining, color: theme.iconTheme.color),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery Time", style: TextStyle(color: theme.hintColor)),
                        Text(
                          order.deliveredTime.split("T").last.split(".").first.substring(0, 5),
                          style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Buttons
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     OutlinedButton(
            //       onPressed: () => Get.toNamed(AppRoutes.complaint),
            //       style: OutlinedButton.styleFrom(
            //         backgroundColor: AppColors.primary,
            //         foregroundColor: AppColors.lightBackground,
            //       ),
            //       child: const Text("Complaint"),
            //     ),
            //     ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: AppColors.primary,
            //         foregroundColor: Colors.white,
            //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            //       ),
            //       child: Text(order.orderStatus),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Order History", style: TextStyle(color: theme.textTheme.titleLarge?.color)),
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: BackButton(color: theme.iconTheme.color),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return controller.completedOrders.isEmpty
                ? const Center(child: Text("No completed orders"))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.completedOrders.length,
                    itemBuilder: (_, i) => _buildOrderCard(
                      constraints,
                      controller.completedOrders[i],
                      theme,
                    ),
                  );
          });
        },
      ),
    );
  }
}
