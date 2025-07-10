// import 'package:dropgo/app/constants/colors.dart';
// import 'package:dropgo/app/constants/custom_size.dart';
// import 'package:dropgo/app/controllers/language_controller.dart';
// import 'package:dropgo/app/controllers/theme_controller.dart';
// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:dropgo/app/views/change_password.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyAccountScreen extends StatelessWidget {
//   final LanguageController langController = Get.put(LanguageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: Text(
//           'My Account',
//           style: TextStyle(
//             color:
//                 Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
//           ),
//         ),
//         backgroundColor: AppColors.primary,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             _buildHeader(context),
//             Responsive.h(context, 1),
//             Expanded(
//               child: ListView(
//                 children: [
//                   // _buildMenuItem(
//                   //   context,
//                   //   image: "assets/images/profile.png",
//                   //   title: 'Edit profile',
//                   //   onTap: () {
//                   //     Get.toNamed(AppRoutes.editprofile);
//                   //   },
//                   // ),
//                   _buildMenuItem(
//                     context,
//                     image: "assets/images/lang.png",
//                     title: 'language'.tr,
//                     onTap: langController.toggleLanguageOptions,
//                   ),
//                   Obx(
//                     () => langController.showLanguageOptions.value
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).cardColor,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: _buildLanguageCards(),
//                             ),
//                           )
//                         : const SizedBox(),
//                   ),
//                   _buildMenuItem(
//                     context,
//                     image: "assets/images/terms.png",
//                     title: 'Terms and conditions',
//                     onTap: () {
//                       Get.toNamed(AppRoutes.terms);
//                     },
//                   ),
//                   _buildMenuItem(
//                     context,
//                     image: "assets/images/changepwd.png",
//                     title: 'Change password',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ChangePasswordScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   _buildMenuItem(
//                     context,
//                     image: "assets/images/logout.png",
//                     title: 'Log out',
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: Icon(
//                       Icons.dark_mode_outlined,
//                       color: AppColors.primary,
//                     ),
//                     title: Text(
//                       "Dark mode",
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     trailing: ThemeToggleButton(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: Theme.of(context).cardColor,
//             child: Icon(
//               Icons.person,
//               size: 40,
//               color: Theme.of(context).iconTheme.color,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Vaishnav',
//                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.phone,
//                       size: 16,
//                       color: Theme.of(context).iconTheme.color,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       '+91 9999998888',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.email,
//                       size: 16,
//                       color: Theme.of(context).iconTheme.color,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       'vaishnav@gmail.com',
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.toNamed(AppRoutes.editprofile);
//             },
//             child: Text(
//               'Edit profile',
//               style: TextStyle(                      color: Theme.of(context).iconTheme.color,
// ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(
//     BuildContext context, {
//     required String image,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       leading: Image.asset(
//         image,
//         color: AppColors.primary,
//         height: 21,
//         width: 21,
//       ),
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
//       ),
//       trailing: Icon(
//         Icons.arrow_forward_ios,
//         color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
//         size: 16,
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _buildLanguageCards() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: GetBuilder<LanguageController>(
//         builder: (controller) {
//           return Column(
//             children: controller.languages.map((lang) {
//               return ListTile(
//                 onTap: () => controller.setLanguage(lang['locale'] as Locale),
//                 leading: const Icon(Icons.language, color: AppColors.primary),
//                 title: Text(
//                   lang['name'] as String,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// class ThemeToggleButton extends StatelessWidget {
//   final ThemeController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Switch(
//         value: controller.isDarkMode.value,
//         onChanged: (val) => controller.toggleTheme(),
//         activeColor: Colors.white,
//         inactiveThumbColor: Colors.black,
//       ),
//     );
//   }
// }

import 'package:dropgo/app/constants/Api_constants.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/language_controller.dart';
import 'package:dropgo/app/controllers/theme_controller.dart';
import 'package:dropgo/app/controllers/profile_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:dropgo/app/views/change_password.dart';
import 'package:dropgo/app/views/editProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountScreen extends StatelessWidget {
  final LanguageController langController = Get.put(LanguageController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            color:
                Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildHeader(context),
            Responsive.h(context, 1),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    context,
                    image: "assets/images/lang.png",
                    title: 'language'.tr,
                    onTap: langController.toggleLanguageOptions,
                  ),
                  Obx(
                    () => langController.showLanguageOptions.value
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _buildLanguageCards(),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  _buildMenuItem(
                    context,
                    image: "assets/images/terms.png",
                    title: 'Terms and conditions',
                    onTap: () {
                      Get.toNamed(AppRoutes.terms);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    image: "assets/images/changepwd.png",
                    title: 'Change password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    image: "assets/images/logout.png",
                    title: 'Log out',
                    onTap: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirm Logout"),
                          content: const Text(
                            "Are you sure you want to log out?",
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: const Text("Logout"),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                        ),
                      );

                      if (shouldLogout == true) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Get.offAllNamed(
                          AppRoutes.login,
                        ); // Navigate to login screen
                      }
                    },
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      "Dark mode",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: ThemeToggleButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(() {
      final user = profileController.user.value;

      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: user?.image != null
                  ? NetworkImage('${ApiConstants.baseUrl}${user!.image}')
                  : null,
              child: user?.image == null
                  ? Icon(Icons.person, size: 30, color: Colors.grey)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'Loading...',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        user?.phone ?? '-',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        user?.email ?? '-',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                if (user != null) {
                  final result = await Get.to(
                    () => EditProfilescreen(
                      name: user.name,
                      email: user.email,
                      phone: user.phone,
                      image: "${ApiConstants.baseUrl}${user.image ?? ''}",
                    ),
                  );

                  if (result == true) {
                    // 🔄 Reload the profile from API after update
                    await profileController.loadProfile();
                  }
                }
              },
              child: Text(
                'Edit profile',
                style: TextStyle(color: Theme.of(context).iconTheme.color),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMenuItem(
    BuildContext context, {
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
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
        size: 16,
      ),
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  final ThemeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Switch(
        value: controller.isDarkMode.value,
        onChanged: (val) => controller.toggleTheme(),
        activeColor: Colors.white,
        inactiveThumbColor: Colors.black,
      ),
    );
  }
}
