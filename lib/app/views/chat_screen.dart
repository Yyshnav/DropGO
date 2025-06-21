import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Customer Service'.tr,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.black),
            onPressed: () {
              chatController.makeDirectCall(
                "9876543210",
              ); // replace with real number
            },
          ),
          SizedBox(width: 10),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
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
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final grouped = <String, List<Message>>{};

              for (var message in chatController.messages) {
                final dateLabel = chatController.formatGroupDate(
                  message.timestamp,
                );
                grouped.putIfAbsent(dateLabel, () => []).add(message);
              }

              final sortedKeys = grouped.keys.toList();

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: grouped.length,
                itemBuilder: (context, index) {
                  final dateKey = sortedKeys[index];
                  final msgs = grouped[dateKey]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Chip(
                          label: Text(dateKey),
                          backgroundColor: const Color(0xFFEFEFEF),
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...msgs.map(
                        (msg) => ChatBubble(
                          message: msg.text,
                          time: msg.time,
                          isSender: msg.isSender,
                          imagePath: msg.imagePath,
                          audioPath: msg.audioPath,
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          Obx(
            () => chatController.isTyping.value
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          'Typing'.tr,
                          style: TextStyle(color: Colors.grey),
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

          // const Divider(height: 1),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              chatController.sendImage();
                            },
                            icon: Icon(
                              Icons.image_outlined,
                              color: Colors.black12,
                            ),
                          ),
                          hintText: 'Message...'.tr,
                          border: InputBorder.none,
                        ),
                        onChanged: (val) {
                          chatController.textController.value = val;
                          chatController.isTyping.value = val.trim().isNotEmpty;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFF045B62)),
                    onPressed: () {
                      chatController.sendMessage(inputController.text);
                      inputController.clear();
                    },
                  ),
                  const SizedBox(width: 4),

                  Obx(
                    () => GestureDetector(
                      onLongPress: () async {
                        await chatController.startRecording();
                      },
                      onLongPressUp: () async {
                        await chatController.stopRecording();
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF045B62),
                        child: Icon(
                          chatController.isRecording.value
                              ? Icons.mic_off
                              : Icons.mic,
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
  final String message;
  final String time;
  final bool isSender;
  final String? imagePath;
  final String? audioPath;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isSender,
    this.imagePath,
    this.audioPath,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xFF045B62) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (imagePath != null && imagePath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(imagePath!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            if (audioPath != null)
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  FlutterSoundPlayer player = FlutterSoundPlayer();
                  player.openPlayer().then((_) {
                    player.startPlayer(fromURI: audioPath);
                  });
                },
              ),

            if (message.isNotEmpty) ...[
              Text(
                message,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: isSender ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
