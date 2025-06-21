// import 'package:dropgo/app/constants/colors.dart';
// import 'package:flutter/material.dart';

// class EditProfilescreen extends StatelessWidget {
//   const EditProfilescreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.lightBackground,
//         elevation: 0,
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             SizedBox(height: size.height * 0.04),
//             Container(
//               height: size.height * 0.65,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.cardbgclr,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Stack(
//                           children: [
//                             CircleAvatar(
//                               radius: size.width * 0.1,
//                               backgroundImage: const NetworkImage(
//                                 'https://tse3.mm.bing.net/th?id=OIP.dCpgPQ0i-xX2gZ-yonm54gHaHa&pid=Api&P=0&h=180',
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 6,
//                               child: const CircleAvatar(
//                                 radius: 12,
//                                 backgroundColor: AppColors.lightBackground,
//                                 child: Icon(
//                                   Icons.edit,
//                                   size: 16,
//                                   color: AppColors.primary,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(width: size.width * 0.04),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: size.height * 0.005),
//                             Text(
//                               'VAISHNAV A',
//                               style: TextStyle(
//                                 fontSize: size.width * 0.05,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                             Text(
//                               'vaishnav@gmail.com',
//                               style: TextStyle(
//                                 color: Colors.grey[600],
//                                 fontSize: size.width * 0.035,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: size.height * 0.02),
//                     Divider(height: 1, color: AppColors.primary),
//                     SizedBox(height: size.height * 0.015),
//                     buildProfileTile("NAME", "VAISHNAV A", size),
//                     buildProfileTile("EMAIL", "vaishnav@gmail.com", size),
//                     buildProfileTile("MOBILENUMBER", "9999988888", size),
//                     Spacer(),
//                     Center(
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             foregroundColor: AppColors.lightBackground,
//                             padding: EdgeInsets.symmetric(
//                               vertical: size.height * 0.018,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             'Save Change',
//                             style: TextStyle(
//                               fontSize: size.width * 0.04,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: size.height * 0.01),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ListTile buildProfileTile(String title, String value, Size size) {
//     return ListTile(
//       onTap: () {},
//       leading: Text(
//         title,
//         style: TextStyle(
//           fontSize: size.width * 0.04,
//           fontWeight: FontWeight.bold,
//           color: AppColors.primary,
//         ),
//       ),
//       trailing: Text(value, style: TextStyle(fontSize: size.width * 0.037)),
//     );
//   }
// }
import 'package:dropgo/app/constants/colors.dart';
import 'package:flutter/material.dart';

class EditProfilescreen extends StatefulWidget {
  const EditProfilescreen({super.key});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  final nameController = TextEditingController(text: 'Vaishnav A');
  final emailController = TextEditingController(text: 'vaishnav@gmail.com');
  final mobileController = TextEditingController(text: '9999988888');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w900,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.04),
            Container(
              height: size.height * 0.65,
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
                              backgroundImage: const NetworkImage(
                                'https://tse3.mm.bing.net/th?id=OIP.dCpgPQ0i-xX2gZ-yonm54gHaHa&pid=Api&P=0&h=180',
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 6,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Theme.of(context).cardColor,
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.04),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.005),
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
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color?.withOpacity(0.7),
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Divider(height: 1, color: AppColors.primary),
                    SizedBox(height: size.height * 0.015),
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
                    const Spacer(),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Use nameController.text, etc.
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.018,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Save Change',
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ),
          ],
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
