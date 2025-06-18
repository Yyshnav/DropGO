// controllers/chat_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class ChatController extends GetxController {
  var messages = <Message>[].obs;
  final textController = ''.obs;
  var isTyping = false.obs;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  RxBool isRecording = false.obs;
  String? recordedPath;

  @override
  void onInit() {
    super.onInit();
    _recorder.openRecorder();
  }

  Future<void> startRecording() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      Get.snackbar("Permission", "Microphone permission denied");
      return;
    }

    final dir = await getTemporaryDirectory();
    final filePath = "${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.aac";

    await _recorder.startRecorder(toFile: filePath);
    recordedPath = filePath;
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    isRecording.value = false;

    // Simulate sending the audio as a message
    if (recordedPath != null) {
      messages.add(
        Message(
          text: "🎤 Voice Message",
          time: DateFormat.Hm().format(DateTime.now()),
          isSender: true,
          timestamp: DateTime.now(),
          audioPath: recordedPath,
        ),
      );
    }
  }

  @override
  void onClose() {
    _recorder.closeRecorder();
    super.onClose();
  }


  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final now = DateTime.now();

    messages.add(
      Message(
        text: text.trim(),
        time: DateFormat.Hm().format(now),
        isSender: true,
        timestamp: now,
      ),
    );

    isTyping.value = false;

    // Fake bot response
    Future.delayed(const Duration(seconds: 1), () {
      final botTime = DateTime.now();
      messages.add(
        Message(
          text: "Thank you for your message!",
          time: DateFormat.Hm().format(botTime),
          isSender: false,
          timestamp: botTime,
        ),
      );
    });

    textController.value = '';
  }

  String formatGroupDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0 &&
        now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      return 'Today';
    } else if (diff == 1 ||
        (diff == 0 && now.day != date.day)) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, y').format(date);
    }
  }

  void sendImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final now = DateTime.now();
    messages.add(
      Message(
        text: '',
        time: DateFormat.Hm().format(now),
        isSender: true,
        timestamp: now,
        imagePath: pickedFile.path,
      ),
    );
  }
}
Future<void> makeDirectCall(String phoneNumber) async {
  var status = await Permission.phone.status;
  if (!status.isGranted) {
    status = await Permission.phone.request();
  }

  if (status.isGranted) {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  } else {
    Get.snackbar("Permission Denied", "Phone call permission is required.");
  }
}
void clearChat() {
  Get.defaultDialog(
    title: 'Clear Chat',
    middleText: 'Are you sure you want to delete all messages?',
    textCancel: 'Cancel',
    textConfirm: 'Clear',
    confirmTextColor: Colors.black,
    cancelTextColor: Colors.grey,
    onConfirm: () {
      messages.clear(); // This will instantly clear all chat messages
      Get.back(); // Close dialog
    },
  );
}
}


class Message {
  final String text;
  final String time;
  final bool isSender;
  final DateTime timestamp;
  final String? imagePath;
  final String? audioPath;

  Message({
    required this.text,
    required this.time,
    required this.isSender,
    required this.timestamp,
    this.imagePath,
    this.audioPath,
  });
}


