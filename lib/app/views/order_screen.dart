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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.cardbgclr,
      appBar: AppBar(
        backgroundColor: AppColors.cardbgclr,
        elevation: 0,
        title: Text('Order'.tr, style: TextStyle(color: Colors.black)),
        // leading: const Icon(Icons.arrow_back, color: Colors.black),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.filter_alt_outlined, color: Colors.black),
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
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      
              // Header
              Row(
                children: [
                  Text(
                    '${"OrderNo.".tr} ${"F15306"}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Spacer(),
                  Text(
                    "13 Oct 2022, 03:53 pm",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
      
              // Route Info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icons with dotted line
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
      
                  // Address Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Bombay Hotel",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text("Kozhikode", style: TextStyle(color: Colors.grey)),
                        SizedBox(height: 18),
                        Text(
                          "Trycode Innovations",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text("Kozhikode", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
      
                  // Distance & Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Distance".tr,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "14 km",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Time".tr,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        "30 min",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
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
