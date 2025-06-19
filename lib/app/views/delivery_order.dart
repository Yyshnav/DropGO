// drop_screen.dart
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/deliveryorder_controller.dart';
import 'package:dropgo/app/controllers/drawer_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DropScreen extends StatelessWidget {
  DropScreen({super.key});
  final controller = Get.put(LocationController());
  final drawerController = Get.put(DrawerControllerX());

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.black,
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
        actions: [
          IconButton(
            onPressed: () {},
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
        backgroundColor: AppColors.primary, // teal-like background
        child: SafeArea(
          child: Obx(
            () => Column(
              children: [
                // Responsive.h(context, 1),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close, color: Colors.white, size: 26),
                  ),
                ),

                // Profile Image
                CircleAvatar(
                  radius: 41,
                  backgroundColor: Colors.white,

                  child: CircleAvatar(
                    radius: 37,
                    // backgroundImage: AssetImage('assets/images/bgimage.png'),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/bgimage.png',
                        fit: BoxFit.fill,
                        height: 74,
                        width: 74,
                      ),
                    ),
                  ),
                ),
                Responsive.h(context, 1.1),

                // Name and Email
                const Text(
                  "Vaishnav A",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "vaishnav@gmail.com",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),

                const SizedBox(height: 30),

                // Menu Items
                buildMenuItem(
                  context,
                  icon: Icons.calendar_month,
                  label: "Calendar",
                  selected: drawerController.selectedItem.value == "Calendar",
                ),
                buildMenuItem(
                  context,
                  icon: Icons.person_outline,
                  label: "My Account",
                  selected: drawerController.selectedItem.value == "My Account",
                ),
                buildMenuItem(
                  context,
                  icon: Icons.location_on_outlined,
                  label: "Address",
                  selected: drawerController.selectedItem.value == "Address",
                ),
                buildMenuItem(
                  context,
                  icon: Icons.support_agent,
                  label: "Support",
                  selected: drawerController.selectedItem.value == "Support",
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
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.currentPosition.value,
                zoom: 15,
              ),
              polylines: controller.routePolyline,
              markers: controller.markers,
              myLocationEnabled: true,
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
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
                        const Text(
                          "Order No. 12",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => controller.toggleTile("delivery"),
                          child: _expandableTile(
                            icon: Icons.location_pin,
                            color: Colors.green,
                            title: "Trycode Innovations Kozhikode",
                            subtitle: "second floor Thayyil Arcade",
                            fullAddress:
                                "Trycode Innovations, 2nd Floor, Thayyil Arcade, Kozhikode, Kerala 673002",
                            isExpanded:
                                controller.expandedTile.value == "delivery",
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
                            const Text(
                              "BOMBAY HOTEL",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
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
                          children: const [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "201/D, Bombay Hotel Kozhikode, Corporation Road",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
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
                              print("++++++++++++++");
                              print("Current route: ${Get.currentRoute}");
                              if (Get.currentRoute != AppRoutes.editprofile) {
                                Get.toNamed(AppRoutes.editprofile);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),


                              
                            ),
                            child: const Text(
                              "Pick Up Orrderh",
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withAlpha(13),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(100)),
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 10),
            Text(
              fullAddress,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        decoration: selected
            ? BoxDecoration(
                color: Color(0xFF29303C),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(icon, color: Colors.white),
          title: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          onTap: () {
            drawerController.setSelected(label);
            // Navigator.pop(context); // close drawer
          },
        ),
      ),
    );
  }
}
