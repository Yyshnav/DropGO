import 'dart:io';
import 'package:dropgo/app/constants/Api_constants.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/controllers/edit_profike.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilescreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String image;

  const EditProfilescreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController mobileController;
  late final TextEditingController imageController;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  final controller = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    mobileController = TextEditingController(text: widget.phone);
    imageController = TextEditingController(text: widget.image);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Edit Profile'.tr,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w900,
          ),
       
        ),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: size.width * 0.1,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: _pickedImage != null
                                    ? FileImage(_pickedImage!)
                                    : (widget.image.isNotEmpty
                                              ? NetworkImage(widget.image)
                                              : const AssetImage(
                                                  'assets/images/default_avatar.png',
                                                ))
                                          as ImageProvider,
                              ),

                              Positioned(
                                bottom: 0,
                                right: 6,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Theme.of(
                                      context,
                                    ).cardColor,
                                    child: const Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: size.width * 0.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nameController.text,
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                emailController.text,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color
                                      ?.withOpacity(0.7),
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Divider(height: 1, color: AppColors.primary),
                      buildEditableTile(
                        context,
                        "NAME",
                        nameController,
                        size.width,
                      ),
                      buildEditableTile(
                        context,
                        "EMAIL",
                        emailController,
                        size.width,
                      ),
                      buildEditableTile(
                        context,
                        "MOBILENUMBER",
                        mobileController,
                        size.width,
                      ),

                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: Obx(() {
                            return ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      final name = nameController.text.trim();
                                      final email = emailController.text.trim();
                                      final phone = mobileController.text
                                          .trim();

                                      controller.updateProfile(
                                        name,
                                        email,
                                        phone,
                                        imageFile: _pickedImage,
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: size.height * 0.018,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : Text(
                                      'Save Change',
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableTile(
    BuildContext context,
    String title,
    TextEditingController controller,
    double width,
  ) {
    return ListTile(
      leading: Text(
        title,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      trailing: SizedBox(
        width: width * 0.45,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: width * 0.037,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
