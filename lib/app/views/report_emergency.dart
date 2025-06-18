import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportEmergencyScreen extends StatelessWidget {
  ReportEmergencyScreen({super.key});
  final EmergencyController controller = Get.put(EmergencyController());

  final List<Map<String, dynamic>> emergencyTypes = [
    {'icon': Icons.car_crash, 'label': 'Accident'},
    {'icon': Icons.fire_truck, 'label': 'Fire'},
    {'icon': Icons.medical_services, 'label': 'Medical'},
    // {'icon': Icons.water_drop, 'label': 'Flood'},
    {'icon': Icons.local_police, 'label': 'Police'},
    {'icon': Icons.more_horiz, 'label': 'Other'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Emergency'),
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: AppColors.lightyellowBg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Responsive.h(context, 1),
            Divider(color: Colors.black12),
            Responsive.h(context, 1),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                    ),
                    title: Obx(
                      () => Text(
                        controller.locationName.value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: Obx(
                      () => Text(
                        controller.place.value,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),

                    trailing: InkWell(
                      onTap: controller.refreshLocation
,
                      child: const Text(
                        'Refresh',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Responsive.h(context, 1),
            Divider(color: Colors.black12),
            const SizedBox(height: 20),
            const Text(
              'Select Emergency type',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildEmergencyCard(
        icon: Icons.local_police,
        label: 'Call 999',
        selected: controller.selectedType.value == 'Call 999',
        onTap: () => controller.selectEmergency('Call 999'),
      ),
      _buildEmergencyCard(
        icon: Icons.admin_panel_settings,
        label: 'Contact Admin',
        selected: controller.selectedType.value == 'Contact Admin',
        onTap: () => controller.selectEmergency('Contact Admin'),
      ),
    ],
  );
}),

            // GridView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: emergencyTypes.length,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 4,
            //     childAspectRatio: 0.8,
            //     crossAxisSpacing: 8,
            //     mainAxisSpacing: 12,
            //   ),
            //   itemBuilder: (context, index) {
            //     final type = emergencyTypes[index];
            //     return Obx(() {
            //       final selected =
            //           controller.selectedType.value == type['label'];

            //       return GestureDetector(
            //         // onTap: () => controller.changeEmergencyType(type['label']),
            //         onTap: () => controller.selectEmergency(type['label']),

            //         child: Column(
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                 color: selected
            //                     ? AppColors.primary
            //                     : const Color.fromARGB(255, 233, 233, 233),
            //                 borderRadius: BorderRadius.circular(14),
            //                 border: selected
            //                     ? Border.all(color: AppColors.primary, width: 2)
            //                     : null,
            //               ),
            //               padding: const EdgeInsets.all(16),
            //               child: Icon(
            //                 type['icon'],
            //                 size: 28,
            //                 color: selected ? Colors.white : Colors.black45,
            //               ),
            //             ),
            //             const SizedBox(height: 4),
            //             Text(
            //               type['label'],
            //               style: TextStyle(
            //                 fontSize: 12,
            //                 color: selected
            //                     ? Colors.black
            //                     : Colors.grey.shade700,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }

Widget _buildEmergencyCard({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required bool selected,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(Get.context!).size.width * 1/2.5,
          height: MediaQuery.of(Get.context!).size.width * 1/3.5,
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primary
                : const Color.fromARGB(255, 233, 233, 233),
            borderRadius: BorderRadius.circular(14),
            border: selected
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(
            icon,
            size: 40,
            color: selected ? Colors.white : Colors.black45,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.black : Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}


}



