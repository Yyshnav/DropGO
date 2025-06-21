import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportEmergencyScreen extends StatelessWidget {
  ReportEmergencyScreen({super.key});
  final EmergencyController controller = Get.put(EmergencyController());

  // final List<Map<String, dynamic>> emergencyTypes = [
  //   {'icon': Icons.car_crash, 'label': 'Accident'},
  //   {'icon': Icons.fire_truck, 'label': 'Fire'},
  //   {'icon': Icons.medical_services, 'label': 'Medical'},
  //   // {'icon': Icons.water_drop, 'label': 'Flood'},
  //   {'icon': Icons.local_police, 'label': 'Police'},
  //   {'icon': Icons.more_horiz, 'label': 'Other'},
  // ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('report_emergency'.tr),
        leading: const BackButton(),
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        elevation: 0,
        foregroundColor: isDark ? AppColors.white : AppColors.black,
      ),
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightyellowBg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Text(
              'location'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkText : Colors.black,
              ),
            ),
            Responsive.h(context, 1),
            Divider(color: isDark ? Colors.white10 : Colors.black12),
            Responsive.h(context, 1),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCardBg
                    : AppColors.lightBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: isDark ? AppColors.darkInactive : Colors.grey,
                    ),
                    title: Obx(
                      () => Text(
                        controller.locationName.value,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkText : Colors.black,
                        ),
                      ),
                    ),
                    subtitle: Obx(
                      () => Text(
                        controller.place.value,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkInactive
                              : Colors.black54,
                        ),
                      ),
                    ),
                    trailing: InkWell(
                      onTap: controller.refreshLocation,
                      child: Text(
                        'refresh'.tr,
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
            Divider(color: isDark ? Colors.white10 : Colors.black12),
            const SizedBox(height: 20),
            Text(
              'select_emergency_type'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.darkText : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEmergencyCard(
                    icon: Icons.local_police,
                    label: 'call_999'.tr,
                    selected: controller.selectedType.value == 'call_999'.tr,
                    onTap: () => controller.selectEmergency('call_999'.tr),
                    isDark: isDark,
                  ),
                  _buildEmergencyCard(
                    icon: Icons.admin_panel_settings,
                    label: 'contact_admin'.tr,
                    selected:
                        controller.selectedType.value == 'contact_admin'.tr,
                    onTap: () => controller.selectEmergency('contact_admin'.tr),
                    isDark: isDark,
                  ),
                ],
              );
            }),
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
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(Get.context!).size.width * 1 / 2.5,
            height: MediaQuery.of(Get.context!).size.width * 1 / 3.5,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : (isDark ? AppColors.darkCardBg : const Color(0xFFE9E9E9)),
              borderRadius: BorderRadius.circular(14),
              border: selected
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(
              icon,
              size: 40,
              color: selected
                  ? Colors.white
                  : (isDark ? AppColors.darkInactive : Colors.black45),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selected
                  ? (isDark ? AppColors.darkText : Colors.black)
                  : (isDark ? AppColors.darkInactive : Colors.grey.shade700),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
