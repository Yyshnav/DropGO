import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAccountScreen extends StatelessWidget {
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
            // Header Section
            Container(
              // color: Color(0xFF7D0A0A),
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vaishnav',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '+91 9999998888',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.email, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'vaishnav@gmail.com',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.editprofile);
                    },
                    child: Text(
                      'Edit profile',
                      style: TextStyle(color: AppColors.primary, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            // Menu List
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    icon: Icons.receipt_long,
                    title: 'My orders',
                    onTap: () {
                      Get.toNamed(AppRoutes.orderhistory);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.headset_mic,
                    title: 'Support',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.description,
                    title: 'Terms and conditions',
                    onTap: () {},
                    //  auto= true;
                  ),
                  _buildMenuItem(
                    icon: Icons.visibility,
                    title: 'Privacy policy',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    icon: Icons.logout,
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: TextStyle(fontSize: 16)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        onTap: onTap,
      ),
    );
  }
}
