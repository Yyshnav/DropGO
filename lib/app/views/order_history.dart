// import 'package:dropgo/app/constants/colors.dart';
// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class OrderHistoryScreen extends StatefulWidget {
//   @override
//   State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
// }

// class _OrderHistoryScreenState extends State<OrderHistoryScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   Widget _buildOrderCard(BoxConstraints constraints) {
//     return Card(
//       shadowColor: AppColors.txtfldclr.withOpacity(0.9),
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Title and Distance
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Nahdi Mandhi",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: constraints.maxWidth * 0.045,
//                     color: AppColors.black,
//                   ),
//                 ),
//                 Text("3.5km", style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//             SizedBox(height: 8),

//             /// Location and Home Icons with dotted line
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Icons + Dots
//                 Column(
//                   children: [
//                     Image.asset(
//                       'assets/images/location.png',
//                       height: 20,
//                       width: 20,
//                       color: AppColors.black,
//                     ),
//                     SizedBox(height: 2),
//                     Column(
//                       children: List.generate(6, (index) {
//                         return Container(
//                           width: 2,
//                           height: 4,
//                           margin: EdgeInsets.symmetric(vertical: 1),
//                           color: Colors.grey,
//                         );
//                       }),
//                     ),
//                     SizedBox(height: 2),
//                     Image.asset(
//                       'assets/images/destination.png',
//                       height: 20,
//                       width: 20,
//                       color: AppColors.black,
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: 8),

//                 /// Texts
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Pushpa Road, Kozhikode",
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: constraints.maxWidth * 0.035,
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       "Trycode Innovations Kozhikode",
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: constraints.maxWidth * 0.035,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),

//             /// Food Items Row
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/images/Frame.png',
//                   height: 20,
//                   width: 20,
//                   color: AppColors.black,
//                 ),
//                 SizedBox(width: 5),
//                 Expanded(
//                   child: Text(
//                     "French Fries(1), Chicken Biryani(2), Smoky Chicken BBQ Burger(1)",
//                     style: TextStyle(
//                       color: AppColors.black,
//                       fontSize: constraints.maxWidth * 0.035,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),

//             /// Order Time and Delivery Time
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/time.png', // Add this asset
//                       height: 20,
//                       width: 20,
//                       color: AppColors.black,
//                     ),
//                     SizedBox(width: 6),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Order Received",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         Text(
//                           "01:10 PM",
//                           style: TextStyle(color: AppColors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/time.png', // Add this asset
//                       height: 20,
//                       width: 20,
//                       color: AppColors.black,
//                     ),
//                     SizedBox(width: 6),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Delivery Time",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         Text(
//                           "01:45 PM",
//                           style: TextStyle(color: AppColors.black),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),

//             /// Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                   onPressed: () {
//                     Get.toNamed(AppRoutes.complaint);
//                   },
//                   child: Text("Complaint"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                   ),
//                   child: Text("Completed"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cardbgclr,
//       appBar: AppBar(
//         title: Text("Order History", style: TextStyle(color: Colors.black)),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: BackButton(color: Colors.black),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Column(
//             children: [
//               TabBar(
//                 controller: _tabController,
//                 labelColor: Colors.teal,
//                 unselectedLabelColor: Colors.black54,
//                 indicatorColor: Colors.teal,
//                 tabs: [
//                   Tab(text: "Completed"),
//                   Tab(text: "Cancelled"),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     ListView(
//                       padding: const EdgeInsets.all(16),
//                       children: [
//                         _buildOrderCard(constraints),
//                         _buildOrderCard(constraints),
//                       ],
//                     ),
//                     Center(
//                       child: Text(
//                         "No cancelled orders.",
//                         style: TextStyle(color: AppColors.primary),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _buildOrderCard(BoxConstraints constraints) {
    final theme = Theme.of(context);

    return Card(
      color: theme.cardColor,
      shadowColor: AppColors.txtfldclr.withOpacity(0.9),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title and Distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nahdi Mandhi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxWidth * 0.045,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                Text("3.5km", style: TextStyle(color: theme.hintColor)),
              ],
            ),
            const SizedBox(height: 8),

            /// Location Icons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      height: 20,
                      width: 20,
                      color: theme.iconTheme.color,
                    ),
                    const SizedBox(height: 2),
                    Column(
                      children: List.generate(6, (index) {
                        return Container(
                          width: 2,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          color: theme.dividerColor,
                        );
                      }),
                    ),
                    const SizedBox(height: 2),
                    Image.asset(
                      'assets/images/destination.png',
                      height: 20,
                      width: 20,
                      color: theme.iconTheme.color,
                    ),
                  ],
                ),
                const SizedBox(width: 8),

                /// Addresses
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pushpa Road, Kozhikode",
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
                        fontSize: constraints.maxWidth * 0.035,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Trycode Innovations Kozhikode",
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
                        fontSize: constraints.maxWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Food Items
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/Frame.png',
                  height: 20,
                  width: 20,
                  color: theme.iconTheme.color,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "French Fries(1), Chicken Biryani(2), Smoky Chicken BBQ Burger(1)",
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: constraints.maxWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Timings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/time.png',
                      height: 20,
                      width: 20,
                      color: theme.iconTheme.color,
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Received",
                          style: TextStyle(color: theme.hintColor),
                        ),
                        Text(
                          "01:10 PM",
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/time.png',
                      height: 20,
                      width: 20,
                      color: theme.iconTheme.color,
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery Time",
                          style: TextStyle(color: theme.hintColor),
                        ),
                        Text(
                          "01:45 PM",
                          style: TextStyle(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Get.toNamed(AppRoutes.complaint),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.lightBackground,
                    side: BorderSide(color: AppColors.primary),
                  ),
                  child: const Text("Complaint"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Completed"),
                ),
              ],
            ),
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
        title: Text(
          "Order History",
          style: TextStyle(color: theme.textTheme.titleLarge?.color),
        ),
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: BackButton(color: theme.iconTheme.color),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: theme.unselectedWidgetColor,
                indicatorColor: AppColors.primary,
                tabs: const [
                  Tab(text: "Completed"),
                  Tab(text: "Cancelled"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        _buildOrderCard(constraints),
                        _buildOrderCard(constraints),
                      ],
                    ),
                    Center(
                      child: Text(
                        "No cancelled orders.",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
