// // Import statements
// import 'package:dropgo/app/controllers/order_controller.dart';
// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dropgo/app/constants/colors.dart';

// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OrderProgressController());

//     return Scaffold(
//       backgroundColor: AppColors.cardbgclr,
//       appBar: AppBar(
//         backgroundColor: AppColors.cardbgclr,
//         elevation: 0,
//         title: const Text('Order', style: TextStyle(color: Colors.black)),
//         actions: const [
//           Icon(Icons.search, color: Colors.black),
//           SizedBox(width: 12),
//           Icon(Icons.filter_alt_outlined, color: Colors.black),
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

// class OrderCard extends StatelessWidget {
//   const OrderCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GestureDetector(
//       onTap: () => Get.toNamed(AppRoutes.orderdetails),
//       child: Card(
//         margin: const EdgeInsets.only(bottom: 16),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//         child: Padding(
//           padding: EdgeInsets.all(size.width * 0.035),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ✅ Ripple + In Progress
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   RippleDot(),
//                   SizedBox(width: 8),
//                   InProgressBadge(),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Header
//               Row(
//                 children: const [
//                   Text(
//                     "OrderNo. F15306",
//                     style: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                   Spacer(),
//                   Text(
//                     "13 Oct 2022, 03:53 pm",
//                     style: TextStyle(fontSize: 12, color: Colors.grey),
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

//               // Route Info
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Icons with dotted line
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

//                   // Address Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Bombay Hotel",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text("Kozhikode", style: TextStyle(color: Colors.grey)),
//                         SizedBox(height: 18),
//                         Text(
//                           "Trycode Innovations",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text("Kozhikode", style: TextStyle(color: Colors.grey)),
//                       ],
//                     ),
//                   ),

//                   // Distance & Time
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Distance",
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       Text(
//                         "14 km",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
//                         ),
//                       ),
//                       SizedBox(height: 18),
//                       Text(
//                         "Time",
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       Text(
//                         "30 min",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black,
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
//       child: const Text(
//         "In Progress",
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
//                     // ignore: deprecated_member_use
//                     color: Colors.green.withOpacity(0.2), // Ripple color
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 8,
//                 height: 8,
//                 decoration: const BoxDecoration(
//                   color: AppColors.primary, // Inner solid dot
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
import 'package:dropgo/app/controllers/order_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropgo/app/constants/colors.dart';

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
          'Order',
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
        actions: [
          Icon(Icons.search, color: Theme.of(context).iconTheme.color),
        title: Text('Order'.tr, style: TextStyle(color: Colors.black)),
        // leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 12),
          Icon(
            Icons.filter_alt_outlined,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: List.generate(
              controller.orders.length,
              (index) => const OrderCard(),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.orderdetails),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  RippleDot(),
                  SizedBox(width: 8),
                  InProgressBadge(),
                ],
              // In Progress badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "In Progress".tr,
                  style: TextStyle(
                    color: AppColors.lightBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                children: [
                  Text(
                    "OrderNo. F15306",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                    '${"OrderNo.".tr} ${"F15306"}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    "13 Oct 2022, 03:53 pm",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

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
              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.store_mall_directory,
                        size: 20,
                        color: Colors.grey,
                      ),
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
                      const Icon(
                        Icons.location_on,
                        size: 23,
                        color: AppColors.activeclr,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bombay Hotel",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Text(
                          "Kozhikode",
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          "Trycode Innovations",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        Text(
                          "Kozhikode",
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                      ],
                    ),
                  ),

                  Column(
      
                  // Distance & Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Distance",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                        "Distance".tr,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "14 km",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).hintColor,
                        ),
                        "Time".tr,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "30 min",
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
}

class InProgressBadge extends StatelessWidget {
  const InProgressBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        "In Progress",
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

class _RippleDotState extends State<RippleDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
