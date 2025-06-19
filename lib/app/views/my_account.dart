import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/language_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountScreen extends StatelessWidget {
  final LanguageController langController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Account', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary, // Red color from the image
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildHeader(),
            Responsive.h(context, 1),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    image: "assets/images/profile.png",
                    title: 'Edit profile',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    image: "assets/images/lang.png",
                    title: 'language'.tr,
                    onTap: langController.toggleLanguageOptions,
                  ),
                  Obx(() => langController.showLanguageOptions.value
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightyellowBg,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _buildLanguageCards()),
                      )
                      : const SizedBox()),
                  _buildMenuItem(
                    image: "assets/images/support.png",
                    title: 'Support',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    image: "assets/images/terms.png",
                    title: 'Terms and conditions',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    image: "assets/images/privacy.png",
                    title: 'Privacy policy',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    image: "assets/images/changepwd.png",
                    title: 'Change password',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    image: "assets/images/logout.png",
                    title: 'Log out',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vaishnav',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.phone, size: 16),
                    SizedBox(width: 4),
                    Text('+91 9999998888', style: TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.email, size: 16),
                    SizedBox(width: 4),
                    Text('vaishnav@gmail.com', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Edit profile',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Image.asset(
        image,
        color: AppColors.primary,
        height: 21,
        width: 21,
      ),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildLanguageCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: GetBuilder<LanguageController>(
        builder: (controller) {
          return Column(
            children: controller.languages.map((lang) {
              return ListTile(
                onTap: () => controller.setLanguage(lang['locale'] as Locale),
                leading: const Icon(Icons.language, color: AppColors.primary),
                title: Text(
                  lang['name'] as String,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
