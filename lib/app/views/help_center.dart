import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  // Text(
                  //   'Contact Us',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(height: 4),
                  // Divider(
                  //   thickness: 2,
                  //   indent: 100,
                  //   endIndent: 100,
                  //   color: Colors.black,
                  // ),
                ],
              ),
            ),
            Responsive.h(context, 2),
            ContactTile(
              icon: 'assets/images/chatt.png',
              label: 'Chat',
              onTap: () {
                // Implement chat action
              },
            ),
            const SizedBox(height: 12),
            ContactTile(
              icon: 'assets/images/whatsapp.png',
              label: 'WhatsApp',
              iconColor: Colors.teal,
              onTap: () {
                // WhatsApp action
              },
            ),
            const SizedBox(height: 12),
            ContactTile(
              icon: 'assets/images/website.png',
              label: 'Website',
              onTap: () {
                // Website action
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  const ContactTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: const Color(0xFFF7F7F7),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Image.asset(icon, color: iconColor, height: 24, width: 24),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
