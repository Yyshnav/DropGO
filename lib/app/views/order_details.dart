// import 'package:audioplayers/audioplayers.dart';
// import 'package:dropgo/app/constants/colors.dart';
// import 'package:dropgo/app/constants/custom_size.dart';
// import 'package:dropgo/app/controllers/orderdetails_controller.dart';

// import 'package:dropgo/app/routes/app_routes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:slide_to_act/slide_to_act.dart';
// import 'package:get/get.dart';

// class OrderDetailsPage extends StatelessWidget {
//   OrderDetailsPage({super.key});

//   final orderController = Get.put(OrderController());
//   final AudioPlayer audioPlayer = AudioPlayer();
//   final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
//   final String voiceNoteUrl =
//       "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
//   final String deliveryNote =
//       "Please leave the parcel at the reception if I’m not available."; // replace with actual note from API

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightyellowBg,
//       appBar: AppBar(
//         toolbarHeight: 70,
//         // leading: IconButton(
//         //   icon: const Icon(Icons.arrow_back, color: Colors.black),
//         //   onPressed: () => Get.back(),
//         // ),
//         title: const Text(
//           'Order Details',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // const Divider(),
//                 Responsive.h(context, 3),

//                 // User Info Row
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipOval(
//                       child: Image.asset(
//                         'assets/images/bgimage.png',
//                         fit: BoxFit.fill,
//                         height: 40,
//                         width: 40,
//                       ),
//                     ),

//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Shabna",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "124 Deliveries",
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Row(
//                             children: [
//                               RatingBarIndicator(
//                                 itemPadding: const EdgeInsets.only(right: 4),
//                                 rating: 4.1,
//                                 itemBuilder: (context, index) =>
//                                     const Icon(Icons.star, color: Colors.amber),
//                                 itemCount: 5,
//                                 itemSize: 18.0,
//                                 direction: Axis.horizontal,
//                               ),
//                               const Text('4.1', style: TextStyle(fontSize: 12)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Color(0xFFFEEBDB),
//                           child: IconButton(
//                             onPressed: () {},
//                             icon: Image.asset(
//                               'assets/images/call.png',
//                               height: 16,
//                               width: 16,
//                             ),
//                           ),
//                         ),
//                         Responsive.w(context, 5),
//                         CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Color(0xFFFEEBDB),
//                           child: IconButton(
//                             icon: Image.asset(
//                               'assets/images/chat.png',
//                               height: 16,
//                               width: 16,
//                             ),
//                             onPressed: () {},
//                           ),
//                         ),
//                         Responsive.w(context, 5),
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColors.lightStatus,
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 6,
//                             ),
//                             child: Text(
//                               'Pending',
//                               style: TextStyle(
//                                 color: AppColors.lightyellowBg,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 Responsive.h(context, 5),

//                 Row(
//                   children: [
//                     Column(
//                       children: [
//                         Image.asset(
//                           'assets/images/pickup.png',
//                           height: 20,
//                           width: 20,
//                         ),
//                         Responsive.h(context, 1),
//                         Icon(
//                           Icons.circle,
//                           size: 8,
//                           color: const Color(0xFF28B877),
//                         ),
//                         Responsive.h(context, 0.7),
//                         Icon(
//                           Icons.circle,
//                           size: 8,
//                           color: const Color(0xFF28B877),
//                         ),
//                         Responsive.h(context, 0.7),
//                         Icon(
//                           Icons.circle,
//                           size: 8,
//                           color: const Color(0xFF28B877),
//                         ),
//                         Responsive.h(context, 1),
//                         Image.asset(
//                           'assets/images/drop.png',
//                           height: 15,
//                           width: 15,
//                         ),
//                       ],
//                     ),
//                     Responsive.w(context, 8),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Pickup Location",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w200,
//                             color: Colors.black54,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Responsive.h(context, 1),
//                         Text(
//                           "Bombay Hotel Kozhikode",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w900,
//                             fontSize: 13,
//                           ),
//                         ),

//                         Responsive.h(context, 2),

//                         Text(
//                           "Delivery Location",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w200,
//                             color: Colors.black54,
//                             fontSize: 12,
//                           ),
//                         ),
//                         Responsive.h(context, 1),
//                         Text(
//                           "Trycode Innovations Kozhikode",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w900,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 Responsive.h(context, 5),

//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Items to be picked",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 12,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     Text(
//                       "Customer contact number",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 12,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text("Biriyani × 1"),
//                               Responsive.w(context, 4),
//                               Image.asset(
//                                 'assets/images/food.png',
//                                 height: 24,
//                                 width: 24,
//                               ),
//                             ],
//                           ),
//                           Responsive.h(context, 1),
//                           Row(
//                             children: [
//                               Text("Alfahm Mandhi × 1"),
//                               Responsive.w(context, 4),
//                               Image.asset(
//                                 'assets/images/food.png',
//                                 height: 24,
//                                 width: 24,
//                               ),
//                             ],
//                           ),
//                           Responsive.h(context, 1),
//                           Row(
//                             children: [
//                               Text("Pepsi 500ml × 1"),
//                               Responsive.w(context, 4),
//                               Image.asset(
//                                 'assets/images/food.png',
//                                 height: 24,
//                                 width: 24,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const Text(
//                       "+91 123456789",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),

//                 Responsive.h(context, 5),

//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Payment Method",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black54,
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       "Amount",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black54,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "COD",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         color: Colors.black54,
//                         fontSize: 13,
//                       ),
//                     ),
//                     Text(
//                       "₹150",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (voiceNoteUrl.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.record_voice_over,
//                           color: Colors.black54,
//                         ),
//                         const SizedBox(width: 8),
//                         const Text(
//                           "Delivery Instructions",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const Spacer(),
//                         ValueListenableBuilder<bool>(
//                           valueListenable: isPlaying,
//                           builder: (context, playing, _) {
//                             return IconButton(
//                               icon: Icon(
//                                 playing
//                                     ? Icons.pause_circle
//                                     : Icons.play_circle,
//                                 size: 30,
//                                 color: AppColors.primary,
//                               ),
//                               onPressed: () async {
//                                 if (playing) {
//                                   await audioPlayer.pause();
//                                 } else {
//                                   await audioPlayer.play(
//                                     UrlSource(voiceNoteUrl),
//                                   );
//                                 }
//                                 isPlaying.value = !playing;
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 if (deliveryNote.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.grey.shade300),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Icon(Icons.notes, color: Colors.black54),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "Customer Note",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   deliveryNote,
//                                   style: const TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 Responsive.h(context, 5),
//                 // const Spacer(),
//                 Obx(() {
//                   if (orderController.isDelivered.value) {
//                     return Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       width: double.infinity,
//                       child: const Text(
//                         "Order Delivered ✅",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.teal,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     );
//                   } else if (!orderController.isPickedUp.value) {
//                     return SlideAction(
//                       text: "Slide to Confirm Pickup",
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                       outerColor: AppColors.primary,
//                       innerColor: AppColors.lightyellowBg,
//                       onSubmit: () {
//                         orderController.confirmPickup();
//                         return null;
//                       },
//                     );
//                   } else {
//                     return SlideAction(
//                       text: "Slide to Deliver Order",
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                       outerColor: AppColors.primary,
//                       innerColor: AppColors.lightyellowBg,
//                       onSubmit: () {
//                         orderController.deliverOrder();
//                         Get.offAndToNamed(AppRoutes.success);
//                         return null;
//                       },
//                     );
//                   }
//                 }),

//                 // // Buttons
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     // Call your pickup logic via controller if needed
//                 //   },
//                 //   style: ElevatedButton.styleFrom(
//                 //     minimumSize: const Size(double.infinity, 50),
//                 //     backgroundColor: AppColors.primary,
//                 //     foregroundColor: AppColors.lightyellowBg,

//                 //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 //   ),
//                 //   child: const Text("Confirm Pickup", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
//                 // ),
//                 // const SizedBox(height: 12),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     // Call your delivery logic via controller if needed
//                 //   },
//                 //   style: ElevatedButton.styleFrom(
//                 //     minimumSize: const Size(double.infinity, 50),
//                 //     backgroundColor: AppColors.primary,
//                 //     foregroundColor: AppColors.lightyellowBg,
//                 //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 //   ),
//                 //   child: const Text("Order Delivered", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
//                 // ),
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:audioplayers/audioplayers.dart';
import 'package:dropgo/app/constants/colors.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/controllers/orderdetails_controller.dart';
import 'package:dropgo/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({super.key});

  final orderController = Get.put(OrderController());
  final AudioPlayer audioPlayer = AudioPlayer();
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  final String voiceNoteUrl =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  final String deliveryNote =
      "Please leave the parcel at the reception if I’m not available.";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.grey[400] : Colors.black54;
    final bgColor = isDark ? Colors.black : AppColors.lightyellowBg;
    final cardColor = isDark ? Colors.grey[900] : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Order Details'.tr,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
       
        ),
        backgroundColor: cardColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textColor),
      ),
      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Responsive.h(context, 3),
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               ClipOval(
      //                 child: Image.asset(
      //                   'assets/images/bgimage.png',
      //                   fit: BoxFit.fill,
      //                   height: 40,
      //                   width: 40,
      //                 ),
      //               ),
      //               const SizedBox(width: 12),
      //               Expanded(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       "Shabna",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 16,
      //                         color: textColor,
      //                       ),
      //                     ),
      //                     const SizedBox(height: 4),
      //                     Text(
      //                       "124 Deliveries",
      //                       style: TextStyle(
      //                         fontSize: 12,
      //                         color: subtitleColor,
      //                       ),
      //                     ),
      //                     const SizedBox(height: 6),
      //                     Row(
      //                       children: [
      //                         RatingBarIndicator(
      //                           itemPadding: const EdgeInsets.only(right: 4),
      //                           rating: 4.1,
      //                           itemBuilder: (context, index) =>
      //                               const Icon(Icons.star, color: Colors.amber),
      //                           itemCount: 5,
      //                           itemSize: 18.0,
      //                           direction: Axis.horizontal,
      //                         ),
      //                         Text(
      //                           '4.1',
      //                           style: TextStyle(
      //                             fontSize: 12,
      //                             color: textColor,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 children: [
      //                   CircleAvatar(
      //                     radius: 18,
      //                     backgroundColor: Color(0xFFFEEBDB),
      //                     child: IconButton(
      //                       onPressed: () {},
      //                       icon: Image.asset(
      //                         'assets/images/call.png',
      //                         height: 16,
      //                         width: 16,
      //                       ),
      //                     ),
      //                   ),
      //                   Responsive.w(context, 5),
      //                   CircleAvatar(
      //                     radius: 18,
      //                     backgroundColor: Color(0xFFFEEBDB),
      //                     child: IconButton(
      //                       icon: Image.asset(
      //                         'assets/images/chat.png',
      //                         height: 16,
      //                         width: 16,
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                   ),
      //                   Responsive.w(context, 5),
      //                   Container(
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(4),
      //                       color: AppColors.lightStatus,
      //                     ),
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(
      //                         horizontal: 8,
      //                         vertical: 6,
      //                       ),
      //                       child: Text(
      //                         'Pending',
      //                         style: TextStyle(
      //                           color: AppColors.lightyellowBg,
      //                           fontSize: 10,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           Responsive.h(context, 5),
      //           Row(
      //             children: [
      //               Column(
      //                 children: [
      //                   Image.asset(
      //                     'assets/images/pickup.png',
      //                     height: 20,
      //                     width: 20,
      //                   ),
      //                   Responsive.h(context, 1),
      //                   ...List.generate(
      //                     3,
      //                     (_) => Column(
      //                       children: [
      //                         Icon(
      //                           Icons.circle,
      //                           size: 8,
      //                           color: const Color(0xFF28B877),
      //                         ),
      //                         Responsive.h(context, 0.7),
      //                       ],
      //                     ),
      //                   ),
      //                   Responsive.h(context, 1),
      //                   Image.asset(
      //                     'assets/images/drop.png',
      //                     height: 15,
      //                     width: 15,
      //                   ),
      //                 ],
      //               ),
      //               Responsive.w(context, 8),
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     "Pickup Location",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w200,
      //                       color: subtitleColor,
      //                       fontSize: 12,
      //                     ),
      //                   ),
      //                   Responsive.h(context, 1),
      //                   Text(
      //                     "Bombay Hotel Kozhikode",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w900,
      //                       fontSize: 13,
      //                       color: textColor,
      //                     ),
      //                   ),
      //                   Responsive.h(context, 2),
      //                   Text(
      //                     "Delivery Location",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w200,
      //                       color: subtitleColor,
      //                       fontSize: 12,
      //                     ),
      //                   ),
      //                   Responsive.h(context, 1),
      //                   Text(
      //                     "Trycode Innovations Kozhikode",
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w900,
      //                       fontSize: 13,
      //                       color: textColor,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           Responsive.h(context, 5),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 "Items to be picked",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w900,
      //                   fontSize: 12,
      //                   color: subtitleColor,
      //                 ),
      //               ),
      //               Text(
      //                 "Customer contact number",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w900,
      //                   fontSize: 12,
      //                   color: subtitleColor,
      //                 ),
      //               ),
      //             ],
      //           ),
      //           const SizedBox(height: 8),
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     ...[
      //                       "Biriyani × 1",
      //                       "Alfahm Mandhi × 1",
      //                       "Pepsi 500ml × 1",
      //                     ].map(
      //                       (item) => Padding(
      //                         padding: const EdgeInsets.only(bottom: 8.0),
      //                         child: Row(
      //                           children: [
      //                             Text(
      //                               item,
      //                               style: TextStyle(color: textColor),
      //                             ),
      //                             Responsive.w(context, 4),
      //                             Image.asset(
      //                               'assets/images/food.png',
      //                               height: 24,
      //                               width: 24,
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Divider(),
            Responsive.h(context, 3),

            // User Info Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/bgimage.png',
                    fit: BoxFit.fill,
                    height: 40,
                    width: 40,
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shabna",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "124 Deliveries".tr,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          RatingBarIndicator(
                            itemPadding: const EdgeInsets.only(right: 4),
                            rating: 4.1,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 18.0,
                            direction: Axis.horizontal,
                          ),
                          const Text('4.1', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFFEEBDB),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/call.png',
                          height: 16,
                          width: 16,
                        ),
                      ),
                    ),
                    Responsive.w(context, 5),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFFEEBDB),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/chat.png',
                          height: 16,
                          width: 16,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Responsive.w(context, 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.lightStatus,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Text(
                          'Pending'.tr,
                          style: TextStyle(
                            color: AppColors.lightyellowBg,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Responsive.h(context, 7),

            Row(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/pickup.png',
                      height: 20,
                      width: 20,
                    ),
                    Responsive.h(context, 1),
                    Icon(Icons.circle, size: 8, color: const Color(0xFF28B877)),
                    Responsive.h(context, 0.7),
                    Icon(Icons.circle, size: 8, color: const Color(0xFF28B877)),
                    Responsive.h(context, 0.7),
                    Icon(Icons.circle, size: 8, color: const Color(0xFF28B877)),
                    Responsive.h(context, 1),
                    Image.asset(
                      'assets/images/drop.png',
                      height: 15,
                      width: 15,
                    ),
                  ],
                ),
                Responsive.w(context, 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pickup Location".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    Responsive.h(context, 1),
                    Text(
                      "Bombay Hotel Kozhikode",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),

                    Responsive.h(context, 2),

                    Text(
                      "Delivery Location".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    Responsive.h(context, 1),
                    Text(
                      "Trycode Innovations Kozhikode",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Responsive.h(context, 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Items to be picked".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Customer contact number".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Biriyani × 1"),
                          Responsive.w(context, 4),
                          Image.asset(
                            'assets/images/food.png',
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                      Responsive.h(context, 1),
                      Row(
                        children: [
                          Text("Alfahm Mandhi × 1"),
                          Responsive.w(context, 4),
                          Image.asset(
                            'assets/images/food.png',
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                    
                    Text(
                      "+91 123456789",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),),
                Responsive.h(context, 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Amount",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "COD",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: subtitleColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "₹150",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),]),
                if (voiceNoteUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.record_voice_over, color: subtitleColor),
                        const SizedBox(width: 8),
                        Text(
                          "Delivery Instructions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const Spacer(),
                        ValueListenableBuilder<bool>(
                          valueListenable: isPlaying,
                          builder: (context, playing, _) {
                            return IconButton(
                              icon: Icon(
                                playing
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                                size: 30,
                                color: AppColors.primary,
                              ),
                              onPressed: () async {
                                if (playing) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer.play(
                                    UrlSource(voiceNoteUrl),
                                  );
                                }
                                isPlaying.value = !playing;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (deliveryNote.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notes, color: subtitleColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Customer Note",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  deliveryNote,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Responsive.h(context, 5),
                Obx(() {
                  if (orderController.isDelivered.value) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      child: Text(
                        "Order Delivered ✅",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (!orderController.isPickedUp.value) {
                    return SlideAction(
                      text: "Slide to Confirm Pickup",
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      outerColor: AppColors.primary,
                      innerColor: AppColors.lightyellowBg,
                      onSubmit: () {
                        orderController.confirmPickup();
                        return null;
                      },
                    );
                  } else {
                    return SlideAction(
                      text: "Slide to Deliver Order",
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      outerColor: AppColors.primary,
                      innerColor: AppColors.lightyellowBg,
                      onSubmit: () {
                        orderController.deliverOrder();
                        Get.offAndToNamed(AppRoutes.success);
                        return null;
                      },
                    );
                  }
                }),
                const SizedBox(height: 16),
             
          
                      Responsive.h(context, 1),
                      Row(
                        children: [
                          Text("Pepsi 500ml × 1"),
                          Responsive.w(context, 4),
                          Image.asset(
                            'assets/images/food.png',
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                  
                  
                
                const Text(
                  "+91 123456789",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
           

            Responsive.h(context, 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "Amount".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "COD".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                Text(
                  "₹150",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),

            const Spacer(),
            Obx(() {
              if (orderController.isDelivered.value) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  child: Text(
                    "Order Delivered ✅".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (!orderController.isPickedUp.value) {
                return SlideAction(
                  text: "Slide to Confirm Pickup".tr,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  outerColor: AppColors.primary,
                  innerColor: AppColors.lightyellowBg,
                  onSubmit: () {
                    orderController.confirmPickup();
                    return null;
                  },
                );
              } else {
                return SlideAction(
                  text: "Slide to Deliver Order".tr,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  outerColor: AppColors.primary,
                  innerColor: AppColors.lightyellowBg,
                  onSubmit: () {
                    orderController.deliverOrder();
                    Get.offAndToNamed(AppRoutes.success);
                    return null;
                  },
                );
              }
            }),

            // // Buttons
            // ElevatedButton(
            //   onPressed: () {
            //     // Call your pickup logic via controller if needed
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50),
            //     backgroundColor: AppColors.primary,
            //     foregroundColor: AppColors.lightyellowBg,

            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //   ),
            //   child: const Text("Confirm Pickup", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
            // ),
            // const SizedBox(height: 12),
            // ElevatedButton(
            //   onPressed: () {
            //     // Call your delivery logic via controller if needed
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50),
            //     backgroundColor: AppColors.primary,
            //     foregroundColor: AppColors.lightyellowBg,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //   ),
            //   child: const Text("Order Delivered", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
            // ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    // )]))]
    //             ),
    //           ],
    //         ),
    //       ))
          );
        
        
      
    
  }
}
