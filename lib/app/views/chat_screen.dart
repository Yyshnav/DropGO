// import 'dart:convert';
// import 'dart:io';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:dropgo/app/constants/api_constants.dart';
// import 'package:dropgo/app/constants/custom_size.dart';
// import 'package:dropgo/app/models/chat_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/chat_controller.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class ChatScreen extends StatelessWidget {
//   final String orderId;

//   const ChatScreen({super.key, required this.orderId});

//   @override
//   Widget build(BuildContext context) {
//     final chatController = Get.put(
//       ChatController(
//         orderId: orderId,
//         mySenderType: SenderType.deliveryBoy,
//       ),
//       tag: orderId,
//     );
//     final inputController = chatController.textController;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: isDark ? Colors.white : Colors.black,
//           ),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Customer Service'.tr,
//           style: TextStyle(
//             color: isDark ? Colors.white : Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.call, color: isDark ? Colors.white : Colors.black),
//             onPressed: () {
//               chatController.makeDirectCall('9876543210');
//             },
//           ),
//           PopupMenuButton<String>(
//             icon: Icon(
//               Icons.more_vert,
//               color: isDark ? Colors.white : Colors.black,
//             ),
//             onSelected: (value) {
//               if (value == 'clear') {
//                 chatController.clearChat();
//               }
//             },
//             itemBuilder: (context) => [
//               PopupMenuItem<String>(
//                 value: 'clear',
//                 child: Text('Clear Chat'.tr),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               if (chatController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               final Map<String, List<MessageModel>> grouped = {};
//               final msgsSorted = [...chatController.messages];
//               msgsSorted.sort((a, b) => a.timestamp.compareTo(b.timestamp));

//               for (var message in msgsSorted) {
//                 final dateLabel = chatController.formatGroupDate(message.timestamp);
//                 grouped.putIfAbsent(dateLabel, () => []).add(message);
//               }

//               final sortedKeys = grouped.keys.toList();

//               return ListView.builder(
             
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       itemCount: sortedKeys.length,
//       itemBuilder: (context, index) {
//         final dateKey = sortedKeys[index];
//         final msgs = grouped[dateKey]!;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: Chip(
//                 label: Text(
//                   dateKey,
//                   style: TextStyle(
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFEFEFEF),
//               ),
//             ),
//             const SizedBox(height: 6),
//             ...msgs.map(
//               (msg) => ChatBubble(
//                 msg: msg,
//                 isMine: !msg.isMine(chatController.mySenderType),
//                 orderId: orderId,
//                 controller: chatController,
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         );
//                 },
//               );
//             }),
//           ),
//           Obx(
//             () => chatController.remoteTyping.value
//                 ? Padding(
//                     padding: const EdgeInsets.only(left: 16.0, bottom: 4),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Typing'.tr,
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(width: 4),
//                         AnimatedTextKit(
//                           animatedTexts: [
//                             TyperAnimatedText(
//                               '...',
//                               textStyle: const TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               speed: const Duration(milliseconds: 300),
//                             ),
//                           ],
//                           totalRepeatCount: 1000,
//                           pause: const Duration(milliseconds: 200),
//                           displayFullTextOnTap: false,
//                           stopPauseOnTap: false,
//                         ),
//                       ],
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: isDark ? Colors.grey[850] : const Color(0xFFF5F5F5),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: TextField(
//                         controller: inputController,
//                         style: TextStyle(
//                           color: isDark ? Colors.white : Colors.black,
//                         ),
//                         decoration: InputDecoration(
//                           suffixIcon: IconButton(
//                             onPressed: chatController.sendImage,
//                             icon: Icon(
//                               Icons.image_outlined,
//                               color: isDark ? Colors.white38 : Colors.black12,
//                             ),
//                           ),
//                           hintText: 'Message...'.tr,
//                           hintStyle: TextStyle(
//                             color: isDark ? Colors.white38 : Colors.black54,
//                           ),
//                           border: InputBorder.none,
//                         ),
//                         onChanged: chatController.onInputChanged,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   IconButton(
//                     icon: const Icon(Icons.send, color: Color(0xFF045B62)),
//                     onPressed: () {
//                       chatController.sendMessage(inputController.text);
//                     },
//                   ),
//                   const SizedBox(width: 4),
//                   Obx(
//                     () => GestureDetector(
//                       onLongPress: chatController.startRecording,
//                       onLongPressUp: chatController.stopRecording,
//                       child: CircleAvatar(
//                         backgroundColor: const Color(0xFF045B62),
//                         child: Icon(
//                           chatController.isRecording.value ? Icons.mic_off : Icons.mic,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final MessageModel msg;
//   final bool isMine;
//   final String orderId;
//   final ChatController controller;


//   const ChatBubble({
//     super.key,
//     required this.msg,
//     required this.isMine,
//     required this.orderId,
//     required this.controller,
//   });

  

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
   
//     // final controller = Get.find<ChatController>(tag: msg.orderId);
//     // final controller = Get.put(ChatController(orderId: orderId, mySenderType: SenderType.deliveryBoy));

//     final bg = isMine
//         ? (isDark ? Colors.grey[800] : const Color(0xFFF2F2F2))
//         : const Color(0xFF045B62);
//     final fg = isMine
//         ? (isDark ? Colors.white : Colors.black87)
//         : Colors.white;

//     Widget? mediaWidget;
// if (msg.mediaType == MediaType.image) {
//       if (msg.mediaUrl != null && msg.mediaUrl!.isNotEmpty) {
//         print('ChatBubble: Processing mediaUrl: ${msg.mediaUrl}'); // Debug log
//         bool isNetworkImage = msg.mediaUrl!.startsWith('http://') || msg.mediaUrl!.startsWith('https://');
//         bool isBase64Image = msg.mediaUrl!.startsWith('data:image/');

//         mediaWidget = isBase64Image
//             ? ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.memory(
//                   base64Decode(msg.mediaUrl!.split(',').last),
//                   width: 200,
//                   height: 200,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     print('Image.memory error: $error'); // Debug log
//                     return const Icon(Icons.broken_image);
//                   },
//                 ),
//               )
//             : isNetworkImage
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: CachedNetworkImage(
//                       imageUrl: msg.mediaUrl!,
//                       width: 200,
//                       height: 200,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                       errorWidget: (context, url, error) {
//                         print('CachedNetworkImage error: $error, URL: $url'); // Debug log
//                         return GestureDetector(
//                           onTap: () {
//                             CachedNetworkImage.evictFromCache(url).then((_) {
//                               // Trigger rebuild if needed
//                               controller.update(); // For GetX
//                             });
//                           },
//                           child: const Icon(Icons.broken_image),
//                         );
//                       },
//                     ),
//                   )
//                 : ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(
//                       File(msg.mediaUrl!),
//                       width: 200,
//                       height: 200,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         print('Image.file error: $error'); // Debug log
//                         return const Icon(Icons.broken_image);
//                       },
//                     ),
//                   );
//       } else {
//         print('ChatBubble: Invalid mediaUrl: ${msg.mediaUrl}'); // Debug log
//         mediaWidget = const Icon(Icons.broken_image);
//       }
// }
//       else if (msg.mediaType == MediaType.audio) {
//   if (msg.mediaUrl != null && msg.mediaUrl!.isNotEmpty) {
//     // print('...........................................................${msg.mediaUrl!}');
//     // print('...........................................................${msg.localPath}');
//     mediaWidget= 
//         Obx(() {
//           final isPlaying = controller.playingMap[msg.id]?.value ?? false;
//           final position = controller.currentPosition(msg.id).value;
//           final duration = controller.totalDuration(msg.id).value;
//           // final position = controller.positionMap[msg.id]?.value ?? Duration.zero;
//           // final duration = controller.durationMap[msg.id]?.value ?? Duration.zero;

//           return Container(
//             width: Responsive.width(context) * 0.50,
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: isMine ? Colors.grey[300] : const Color.fromARGB(87, 108, 136, 136),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: isMine ? Colors.black : Colors.white,
//                   ),
//                   onPressed: () {
//                     final isPlaying = controller.playingMap[msg.id]?.value ?? false;
//                     final isPaused = controller.pausedMap[msg.id]?.value ?? false;

//                     if (isPlaying) {
//                       controller.pauseAudio(msg.id);
//                     } else if (isPaused) {
//                       controller.resumeAudio(msg.id);
//                     } else {
//                       print( 'Playing audio from URL.......................................................: ${msg.mediaUrl!}');
//                       controller.playAudio(msg.mediaUrl!, msg.id);
//                     }
//                   },
//                 ),
//                 Expanded(
//                   child:  Slider(
//                         min: 0,
//                         max: duration.inMilliseconds > 0 ? duration.inMilliseconds.toDouble() : 1,
//                         value: position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble(),
//                         onChanged: (value) {
//                           controller.seekAudio(
//                             msg.id,
//                             Duration(milliseconds: value.toInt()),
//                           );
//                         },
//                       ),
                    
                  
//                 ),
                
//                 Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       _formatDuration(position),
//       style: TextStyle(
//         color: isMine ? Colors.black : Colors.white,
//         fontSize: 12,
//       ),
//     ),
//     Text(
//       _formatDuration(duration),
//       style: TextStyle(
//         color: isMine ? Colors.black : Colors.white,
//         fontSize: 12,
//       ),
//     ),
//   ],
// ),
//               ],
//             ),
//           );
//         });

//   } else {
//     mediaWidget = const Text('Audio not available');
//   }
// }

// if ((msg.text.isEmpty) && mediaWidget == null) {
//     return const SizedBox.shrink();
//   }


//     return Align(
//       alignment: isMine ? Alignment.centerLeft : Alignment.centerRight, // Swapped alignment
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: isMine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//           children: [
//             if (mediaWidget != null) ...[
//               mediaWidget,
//               const SizedBox(height: 4),
//             ],
//             if (msg.text.isNotEmpty) ...[
//               Text(
//                 msg.text,
//                 style: TextStyle(color: fg),
//               ),
//               const SizedBox(height: 4),
//             ],
//             Text(
//               msg.timeString,
//               style: TextStyle(
//                 fontSize: 10,
//                 color: isMine
//                     ? (isDark ? Colors.grey[400] : Colors.grey)
//                     : Colors.white70,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// String _formatDuration(Duration d) {
//   final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
//   final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
//   return '$minutes:$seconds';
// }

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dropgo/app/constants/api_constants.dart';
import 'package:dropgo/app/constants/custom_size.dart';
import 'package:dropgo/app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatScreen extends StatelessWidget {
  final String orderId;

  const ChatScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(
      ChatController(
        orderId: orderId,
        mySenderType: SenderType.deliveryBoy,
      ),
      tag: orderId,
    );
    final inputController = chatController.textController;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Customer Service'.tr,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              chatController.makeDirectCall('9876543210');
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: isDark ? Colors.white : Colors.black,
            ),
            onSelected: (value) {
              if (value == 'clear') {
                chatController.clearChat();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'clear',
                child: Text('Clear Chat'.tr),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final Map<String, List<MessageModel>> grouped = {};
              final msgsSorted = [...chatController.messages];
              msgsSorted.sort((a, b) => a.timestamp.compareTo(b.timestamp));

              for (var message in msgsSorted) {
                final dateLabel = chatController.formatGroupDate(message.timestamp);
                grouped.putIfAbsent(dateLabel, () => []).add(message);
              }

              final sortedKeys = grouped.keys.toList();

              return ListView.builder(
                // reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                itemCount: sortedKeys.length,
                itemBuilder: (context, index) {
                  final dateKey = sortedKeys[index];
                  final msgs = grouped[dateKey]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Chip(
                          label: Text(
                            dateKey,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFEFEFEF),
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...msgs.map(
                        (msg) => ChatBubble(
                          msg: msg,
                          isMine: !msg.isMine(chatController.mySenderType),
                          orderId: orderId,
                          controller: chatController,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              );
            }),
          ),
          Obx(
            () => chatController.remoteTyping.value
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          'Typing'.tr,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 4),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              '...',
                              textStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              speed: const Duration(milliseconds: 300),
                            ),
                          ],
                          totalRepeatCount: 1000,
                          pause: const Duration(milliseconds: 200),
                          displayFullTextOnTap: false,
                          stopPauseOnTap: false,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[850] : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: inputController,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: chatController.sendImage,
                            icon: Icon(
                              Icons.image_outlined,
                              color: isDark ? Colors.white38 : Colors.black12,
                            ),
                          ),
                          hintText: 'Message...'.tr,
                          hintStyle: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black54,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: chatController.onInputChanged,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF045B62)),
                    onPressed: () {
                      chatController.sendMessage(inputController.text);
                    },
                  ),
                  const SizedBox(width: 4),
                  Obx(
                    () => GestureDetector(
                      onLongPress: chatController.startRecording,
                      onLongPressUp: chatController.stopRecording,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF045B62),
                        child: Icon(
                          chatController.isRecording.value ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageModel msg;
  final bool isMine;
  final String orderId;
  final ChatController controller;

  const ChatBubble({
    super.key,
    required this.msg,
    required this.isMine,
    required this.orderId,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isMine
        ? (isDark ? Colors.grey[800] : const Color(0xFFF2F2F2))
        : const Color(0xFF045B62);
    final fg = isMine
        ? (isDark ? Colors.white : Colors.black87)
        : Colors.white;

    Widget? mediaWidget;
    if (msg.mediaType == MediaType.image) {
      if (msg.mediaUrl != null && msg.mediaUrl!.isNotEmpty) {
        print('ChatBubble: Processing mediaUrl: ${msg.mediaUrl}'); // Debug log
        bool isNetworkImage = msg.mediaUrl!.startsWith('http://') || msg.mediaUrl!.startsWith('https://');
        bool isBase64Image = msg.mediaUrl!.startsWith('data:image/');

        mediaWidget = isBase64Image
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.memory(
                  base64Decode(msg.mediaUrl!.split(',').last),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Image.memory error: $error'); // Debug log
                    return const Icon(Icons.broken_image);
                  },
                ),
              )
            : isNetworkImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: msg.mediaUrl!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        print('CachedNetworkImage error: $error, URL: $url'); // Debug log
                        return GestureDetector(
                          onTap: () {
                            CachedNetworkImage.evictFromCache(url).then((_) {
                              controller.update(); // For GetX
                            });
                          },
                          child: const Icon(Icons.broken_image),
                        );
                      },
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(msg.mediaUrl!),
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Image.file error: $error');
                        return const Icon(Icons.broken_image);
                      },
                    ),
                  );
      } else {
        print('ChatBubble: Invalid mediaUrl: ${msg.mediaUrl}');
        mediaWidget = const Icon(Icons.broken_image);
      }
      
     } else if (msg.mediaType == MediaType.audio && msg.mediaUrl != null && msg.mediaUrl!.isNotEmpty) {
  // Debug print to check width and duration
  print('Audio widget width: ${MediaQuery.of(context).size.width * 0.5}, msg.id: ${msg.id}');
  mediaWidget = Container(
  width: 200, // Fixed width for testing
  padding: const EdgeInsets.all(4),
  decoration: BoxDecoration(
    color: isMine ? Colors.grey[300] : const Color.fromARGB(87, 108, 136, 136),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Obx(() => IconButton(
            icon: Icon(
              (controller.playingMap[msg.id]?.value ?? false) ? Icons.pause : Icons.play_arrow,
              size: 16,
            ),
            onPressed: () => controller.playAudio(msg.localPath ?? msg.mediaUrl!, msg.id),
          )),
      Expanded(
        child: Obx(() => Slider(
              value: (controller.positionMap[msg.id]?.value.inMilliseconds ?? 0) /
                  (controller.durationMap[msg.id]?.value.inMilliseconds ?? 1),
              onChanged: (value) => controller.seekAudio(
                  msg.id,
                  Duration(
                      milliseconds:
                          (value * (controller.durationMap[msg.id]?.value.inMilliseconds ?? 1))
                              .toInt())),
              min: 0.0,
              max: 1.0,
            )),
      ),
    ],
  ),
);

  // mediaWidget = Container(
  //   constraints: BoxConstraints(
  //     maxWidth: min(MediaQuery.of(context).size.width * 0.5, 300), // Reliable width cap
  //   ),
  //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //   decoration: BoxDecoration(
  //     color: isMine ? Colors.grey[300] : const Color.fromARGB(87, 108, 136, 136),
  //     borderRadius: BorderRadius.circular(16),
  //   ),
  //   child: Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Obx(() {
  //         final isPlaying = controller.playingMap[msg.id]!.value; // Safe now due to init
  //         return IconButton(
  //           padding: EdgeInsets.zero,
  //           constraints: const BoxConstraints(minWidth: 40),
  //           icon: Icon(
  //             isPlaying ? Icons.pause : Icons.play_arrow,
  //             color: isMine ? Colors.black : Colors.white,
  //             size: 20,
  //           ),
  //           onPressed: () {
  //             final isPlaying = controller.playingMap[msg.id]!.value;
  //             final isPaused = controller.pausedMap[msg.id]!.value;

  //             if (isPlaying) {
  //               controller.pauseAudio(msg.id);
  //             } else if (isPaused) {
  //               controller.resumeAudio(msg.id);
  //             } else {
  //               print('Playing audio from URL: ${msg.localPath ?? msg.mediaUrl}');
  //               controller.playAudio(msg.localPath ?? msg.mediaUrl!, msg.id);
  //             }
  //           },
  //         );
  //       }),
  //       Expanded( // Use Expanded for Slider to fill remaining space
  //         child: Obx(() {
  //           final position = controller.positionMap[msg.id]!.value;
  //           final duration = controller.durationMap[msg.id]!.value;
  //           print('Duration for ${msg.id}: $duration'); // Debug duration
  //           final progress = duration.inMilliseconds > 0
  //               ? (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0)
  //               : 0.0;

  //           return Slider(
  //             value: progress,
  //             onChanged: duration.inMilliseconds > 0
  //                 ? (value) {
  //                     final newPosition = Duration(
  //                       milliseconds: (value * duration.inMilliseconds).toInt(),
  //                     );
  //                     controller.seekAudio(msg.id, newPosition);
  //                   }
  //                 : null,
  //             onChangeStart: (value) {
  //               if (controller.playingMap[msg.id]!.value) {
  //                 controller.pauseAudio(msg.id);
  //               }
  //             },
  //             onChangeEnd: (value) {
  //               if (controller.pausedMap[msg.id]!.value) {
  //                 controller.resumeAudio(msg.id);
  //               }
  //             },
  //             activeColor: isMine ? Colors.blue : Colors.white,
  //             inactiveColor: isMine ? Colors.grey : Colors.white70,
  //             min: 0.0,
  //             max: 1.0,
  //           );
  //         }),
  //       ),
  //       Flexible(
  //         fit: FlexFit.loose,
  //         child: Obx(() {
  //           final position = controller.positionMap[msg.id]!.value;
  //           final duration = controller.durationMap[msg.id]!.value;
  //           return Padding(
  //             padding: const EdgeInsets.only(left: 4),
  //             child: Text(
  //               "${_formatDuration(position)}/${_formatDuration(duration)}",
  //               style: TextStyle(
  //                 color: isMine ? Colors.black : Colors.white,
  //                 fontSize: 9,
  //               ),
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           );
  //         }),
  //       ),
  //     ],
  //   ),
  // );
}
    // } else if (msg.mediaType == MediaType.audio && msg.mediaUrl != null && msg.mediaUrl!.isNotEmpty) {
    //   mediaWidget = Obx(() {
    //     final isPlaying = controller.playingMap[msg.id]?.value ?? false;
    //     final position = controller.currentPosition(msg.id).value;
    //     final duration = controller.totalDuration(msg.id).value;

    //     // CORRECTED: Ensure progress is clamped and duration is displayed
    //     double progress = duration.inMilliseconds > 0
    //         ? (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0)
    //         : 0.0;

    //     return Container(
    //       width: Responsive.width(context) * 0.50,
    //       padding: const EdgeInsets.all(10),
    //       decoration: BoxDecoration(
    //         color: isMine ? Colors.grey[300] : const Color.fromARGB(87, 108, 136, 136),
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       child: Row(
    //         children: [
    //           IconButton(
    //             icon: Icon(
    //               isPlaying ? Icons.pause : Icons.play_arrow,
    //               color: isMine ? Colors.black : Colors.white,
    //             ),
    //             onPressed: () {
    //               final isPlaying = controller.playingMap[msg.id]?.value ?? false;
    //               final isPaused = controller.pausedMap[msg.id]?.value ?? false;

    //               if (isPlaying) {
    //                 controller.pauseAudio(msg.id);
    //               } else if (isPaused) {
    //                 controller.resumeAudio(msg.id);
    //               } else {
    //                 // CORRECTED: Use localPath if available for audio playback
    //                 print('Playing audio from URL: ${msg.localPath ?? msg.mediaUrl}');
    //                 controller.playAudio(msg.localPath ?? msg.mediaUrl!, msg.id);
    //               }
    //             },
    //           ),
    //           Expanded(
    //             child: Slider(

    //               value: progress,
    //               onChanged: duration.inMilliseconds > 0
    //                   ? (value) {
    //                       final newPosition = Duration(
    //                           milliseconds: (value * duration.inMilliseconds).toInt());
    //                       controller.seekAudio(msg.id, newPosition);
    //                     }
    //                   : null,
    //               // CORRECTED: Added visual feedback for slider
    //               activeColor: isMine ? Colors.blue : Colors.white,
    //               inactiveColor: isMine ? Colors.grey : Colors.white70,
    //             ),
    //           ),
    //           // CORRECTED: Display both current position and total duration
    //           Text(
    //             "${_formatDuration(position)} / ${_formatDuration(duration)}",
    //             style: TextStyle(
    //               color: isMine ? Colors.black : Colors.white,
    //               fontSize: 12,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // }

    if (msg.text.isEmpty && mediaWidget == null) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: isMine ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isMine ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (mediaWidget != null) ...[
              mediaWidget,
              const SizedBox(height: 4),
            ],
            if (msg.text.isNotEmpty) ...[
              Text(
                msg.text,
                style: TextStyle(color: fg),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              msg.timeString,
              style: TextStyle(
                fontSize: 10,
                color: isMine
                    ? (isDark ? Colors.grey[400] : Colors.grey)
                    : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDuration(Duration d) {
  if (d.isNegative) return '00:00'; // Handle negative durations
  final hours = d.inHours;
  final minutes = d.inMinutes.remainder(60);
  final seconds = d.inSeconds.remainder(60);
  if (hours > 0) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  } else {
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}