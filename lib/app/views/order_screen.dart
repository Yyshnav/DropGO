import 'package:dropgo/app/controllers/order_controller.dart';
import 'package:dropgo/app/models/all_orders_model.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropgo/app/constants/colors.dart';

// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OrderProgressController());

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         title: Text(
//           'Order'.tr,
//           style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
//         ),
//         actions: [
//           Icon(Icons.search, color: Theme.of(context).iconTheme.color),
//           SizedBox(width: 12),
//           Icon(
//             Icons.filter_alt_outlined,
//             color: Theme.of(context).iconTheme.color,
//           ),
//           SizedBox(width: 12),
                  
//         ],
//       ),
//       body: Obx(
//         () => SingleChildScrollView(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: List.generate(
//               controller.orders.length,
//               (index) => const OrderCard(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderProgressController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Order'.tr,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        actions: [
          Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 12),
          Icon(Icons.filter_alt_outlined, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 12),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.orders.isEmpty) {
          return Center(
            child: Text(
              "No orders available",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: List.generate(
              controller.orders.length,
              (index) => OrderCard(index: index),
            ),
          ),
        );
      }),
    );
  }
}


// class OrderCard extends StatelessWidget {
//   const OrderCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GestureDetector(
//       onTap: () => Get.toNamed(AppRoutes.orderdetails),
//       child: Card(
//         color: Theme.of(context).cardColor,
//         margin: const EdgeInsets.only(bottom: 16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//         child: Padding(
//           padding: EdgeInsets.all(size.width * 0.035),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   RippleDot(),
//                   SizedBox(width: 8),
//                   InProgressBadge(),
//                 ],
//               // In Progress badge
//               // Container(
//               //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               //   decoration: BoxDecoration(
//               //     color: AppColors.primary,
//               //     borderRadius: BorderRadius.circular(6),
//               //   ),
//               //   child: Text(
//               //     "In Progress".tr,
//               //     style: TextStyle(
//               //       color: AppColors.lightBackground,
//               //       fontWeight: FontWeight.w600,
//               //       fontSize: 12,
//               //     ),
//               //   ),
//               ),
//               const SizedBox(height: 12),

//               Row(
//                 children: [
//                 Text(
//                     // "OrderNo. F15306",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Theme.of(context).hintColor,
//                     ),
//                     '${"OrderNo.".tr} ${"F15306"}',
//                     // style: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "13 Oct 2022, 03:53 pm",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Theme.of(context).hintColor,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6),

//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: AppColors.activebgclr,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   "Active",
//                   style: TextStyle(fontSize: 12, color: AppColors.activeclr),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       const Icon(
//                         Icons.store_mall_directory,
//                         size: 20,
//                         color: Colors.grey,
//                       ),
//                       Column(
//                         children: List.generate(
//                           6,
//                           (index) => Container(
//                             width: 2,
//                             height: 4,
//                             margin: const EdgeInsets.symmetric(vertical: 2),
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                       const Icon(
//                         Icons.location_on,
//                         size: 23,
//                         color: AppColors.activeclr,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: 10),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Bombay Hotel",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                           ),
//                         ),
//                         Text(
//                           "Kozhikode",
//                           style: TextStyle(color: Theme.of(context).hintColor),
//                         ),
//                         const SizedBox(height: 18),
//                         Text(
//                           "Trycode Innovations",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: Theme.of(context).textTheme.bodyLarge?.color,
//                           ),
//                         ),
//                         Text(
//                           "Kozhikode",
//                           style: TextStyle(color: Theme.of(context).hintColor),
//                         ),
//                       ],
//                     ),
//                   ),

                      
//                   // Distance & Time
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Distance".tr,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Theme.of(context).hintColor,
//                         ),
                        
//                       ),
//                       Text(
//                         "14 km",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: Theme.of(context).textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                       const SizedBox(height: 18),
//                       Text(
//                         "Time".tr,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Theme.of(context).hintColor,
//                         ),
                         
//                       ),
//                       Text(
//                         "30 min",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: Theme.of(context).textTheme.bodyLarge?.color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<OrderProgressController>();
    final order = ctrl.orders[index];

    // safe fallback
    final distanceKm = (index < ctrl.distancesKm.length)
        ? ctrl.distancesKm[index].toStringAsFixed(1)
        : '--';

    final timeMin = (index < ctrl.timesMin.length)
        ? ctrl.timesMin[index].toString()
        : '--';

    final size = MediaQuery.of(context).size;

    // Format date/time
    final createdStr = _formatDateTime(order.createdAt);

    // Translate backend status -> UI text
    final isActive = order.status.toUpperCase() == 'PENDING' || order.status.toUpperCase() == 'IN_PROGRESS';
    final badgeText = isActive ? "In Progress".tr : order.status.tr;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.orderdetails, arguments: order.id.toString(), ),
      child: Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ripple + badge row  (unchanged look)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RippleDot(),
                  const SizedBox(width: 8),
                  InProgressBadge(label: badgeText),
                ],
              ),
              const SizedBox(height: 12),

              // order no + date row
              Row(
                children: [
                  Text(
                    '${"OrderNo.".tr} ${order.id}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    createdStr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // "Active" chip (keep style; show when active)
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.activebgclr,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Active",
                    style: TextStyle(fontSize: 12, color: AppColors.activeclr),
                  ),
                ),
              if (isActive) const SizedBox(height: 12),

              // main row: pickup -> drop + distance/time
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.store_mall_directory, size: 20, color: Colors.grey),
                      Column(
                        children: List.generate(
                          6,
                          (index) => Container(
                            width: 2,
                            height: 4,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Icon(Icons.location_on, size: 23, color: AppColors.activeclr),
                    ],
                  ),
                  const SizedBox(width: 10),

                  // pickup + drop text column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.pickupName,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Text(
                          order.pickupCity,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          order.dropName,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Text(
                          order.dropCity,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                  ),

                  // distance + time column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Distance".tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        "$distanceKm km",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Time".tr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      Text(
                        "$timeMin min",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    // Very lightweight format; adjust as needed
    final dd = dt.day.toString().padLeft(2, '0');
    final mm = dt.month.toString().padLeft(2, '0');
    final yyyy = dt.year.toString();
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return "$dd/$mm/$yyyy, $hh:$min";
  }
}


// class InProgressBadge extends StatelessWidget {
//   const InProgressBadge({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         "In Progress".tr,
//         style: TextStyle(
//           color: AppColors.lightBackground,
//           fontWeight: FontWeight.w600,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }
// }

// class RippleDot extends StatefulWidget {
//   const RippleDot({super.key});

//   @override
//   State<RippleDot> createState() => _RippleDotState();
// }

// class _RippleDotState extends State<RippleDot>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     )..repeat(reverse: true);

//     _scale = Tween<double>(
//       begin: 1.0,
//       end: 2.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 20,
//       height: 20,
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (_, __) {
//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               Transform.scale(
//                 scale: _scale.value,
//                 child: Container(
//                   width: 12,
//                   height: 12,
//                   decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(0.2),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primary,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class InProgressBadge extends StatelessWidget {
  const InProgressBadge({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.lightBackground,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class RippleDot extends StatefulWidget {
  const RippleDot({super.key});

  @override
  State<RippleDot> createState() => _RippleDotState();
}

class _RippleDotState extends State<RippleDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: _scale.value,
                child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), shape: BoxShape.circle)),
              ),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
            ],
          );
        },
      ),
    );
  }
}  