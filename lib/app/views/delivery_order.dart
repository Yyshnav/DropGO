import 'package:dropgo/app/constants/Api_constants.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/deliveryorder_controller.dart';
import 'package:dropgo/app/controllers/drawer_controller.dart';
import 'package:dropgo/app/controllers/profile_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropScreen extends StatelessWidget {
  DropScreen({super.key});
  final controller = Get.put(LocationController());
  final drawerController = Get.put(DrawerControllerX());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String orderId = ''; 
    controller.fetchOrderDetails(orderId);

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Drop ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              TextSpan(
                text: 'GO',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: isDark ? Colors.black : Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.reportemergency);
            },
            icon: Image.asset('assets/images/sos.png', height: 24, width: 24),
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset(
              'assets/images/drawer.png',
              height: 28,
              width: 28,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        backgroundColor: isDark ? Colors.grey[900]! : AppColors.primary,
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, color: Colors.white, size: 26),
                  ),
                ),
                Obx(() {
                  final user = profileController.user.value;

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 41,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 37,
                          backgroundImage: user?.image != null
                              ? NetworkImage(
                                  '${ApiConstants.baseUrl}${user!.image}',
                                )
                              : const AssetImage('assets/images/bgimage.png')
                                    as ImageProvider,
                        ),
                      ),
                      Responsive.h(context, 1.1),
                      Text(
                        user?.name ?? 'Loading...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '-',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 30),
                buildMenuItem(
                  context,
                  icon: Icons.calendar_month,
                  label: "My orders".tr,
                  selected:
                      drawerController.selectedItem.value == "My orders".tr,
                ),
                buildMenuItem(
                  context,
                  icon: Icons.person_outline,
                  label: "My Account".tr,
                  selected:
                      drawerController.selectedItem.value == "My Account".tr,
                ),

                buildMenuItem(
                  context,
                  icon: Icons.support_agent,
                  label: "Support".tr,
                  selected: drawerController.selectedItem.value == "Support".tr,
                ),
                
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (!controller.isVehicleIconLoaded.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.deliveryOrder.value == null) {
    return GoogleMap(
      cloudMapId: '30bbabd0238e299ab41897f0',
      onMapCreated: controller.onMapCreated,
      initialCameraPosition: CameraPosition(
        target: controller.currentPosition.value,
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: controller.currentPosition.value,
          icon: controller.vehicleIcon,
        ),
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: false,
      minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
    );
  }

        final order = controller.deliveryOrder.value!;
        return Stack(
          children: [
            GoogleMap(
              cloudMapId: '30bbabd0238e299ab41897f0',
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.currentPosition.value,
                zoom: 15,
              ),
              polylines: controller.routePolyline,
              markers: controller.markers,
              myLocationEnabled: false,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(10, 18),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              minChildSize: 0.2,
              maxChildSize: 0.65,
              builder: (context, scrollController) {
                return Obx(
                  () => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black54 : Colors.black12,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            height: 4,
                            width: 40,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Order No. ${order.orderId}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // GestureDetector(
                        //   onTap: () => controller.toggleTile("delivery"),
                        //   child: _expandableTile(
                        //     icon: Icons.location_pin,
                        //     color: Colors.green,
                        //     title: "Trycode Innovations Kozhikode",
                        //     subtitle: "second floor Thayyil Arcade",
                        //     fullAddress:
                        //         "Trycode Innovations, 2nd Floor, Thayyil Arcade, Kozhikode, Kerala 673002",
                        //     isExpanded:
                        //         controller.expandedTile.value == "delivery",
                        //     buttonText: "View Delivery Map",
                        //     controller: controller,
                        //   ),
                        // ),
                        GestureDetector(
                        onTap: () => controller.toggleTile("delivery"),
                        child: _expandableTile(
                          icon: Icons.location_pin,
                          color: Colors.green,
                          title: order.deliveryLocationName, 
                          subtitle: order.deliveryAddress,
                          fullAddress: order.deliveryAddress,
                          isExpanded: controller.expandedTile.value == "delivery",
                          buttonText: "View Delivery Map",
                          controller: controller,
                        ),
                      ),
                        const SizedBox(height: 12),
                        const Divider(),
                        Row(
                          children: [
                            const Icon(Icons.storefront),
                            const SizedBox(width: 8),
                            Text(
                              // "BOMBAY HOTEL",
                              order.pickupLocationName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.call, color: Colors.teal),
                              onPressed: () {
                                controller.makePhoneCall("+919995518067");
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                order.pickupAddress,
                                // "201/D, Bombay Hotel Kozhikode, Corporation Road",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? Colors.grey[400]
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (Get.currentRoute != AppRoutes.editprofile) {
                                Get.toNamed(AppRoutes.orderscreen);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Pick Up Order",
                              style: TextStyle(
                                color: AppColors.lightBackground,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _expandableTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String fullAddress,
    required bool isExpanded,
    required String buttonText,
    required LocationController controller,
  }) {
    final isDark = Theme.of(Get.context!).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 10),
            Text(
              fullAddress,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: controller.animateToDelivery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(color: AppColors.lightBackground),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: selected
            ? BoxDecoration(
                color: isDark ? Colors.white12 : const Color(0xFF29303C),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(icon, color: Colors.white),
          title: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onTap: () {
            drawerController.setSelected(label);
          },
        ),
      ),
    );
  }
}
