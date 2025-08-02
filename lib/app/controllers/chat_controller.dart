// controllers/chat_controller.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dropgo/app/constants/Api_constants.dart';
import 'package:dropgo/app/constants/Api_service.dart';
import 'package:dropgo/app/constants/chat_websocket.dart';
import 'package:dropgo/app/models/chat_model.dart';
import 'package:dropgo/demotest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class ChatController extends GetxController {
  final String orderId;
  final SenderType mySenderType;
  final DeliveryAuthApis _api;
  final ChatSocketService _socket;

  var messages = <MessageModel>[].obs;
  var isTyping = false.obs;
  var remoteTyping = false.obs;
  var isLoading = false.obs;
  var isConnected = false.obs;
  final RxBool isSending = false.obs;

  final textController = TextEditingController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  RxBool isRecording = false.obs;
  String? recordedPath;

  final FlutterSoundPlayer _player = FlutterSoundPlayer();
RxBool isPlaying = false.obs;
// Rx<Duration> currentPosition = Duration.zero.obs;
// Rx<Duration> totalDuration = Duration.zero.obs;
StreamSubscription? _positionSub;

final Map<String, RxBool> playingMap = {};
final Map<String, Rx<Duration>> positionMap = {};
final Map<String, Rx<Duration>> durationMap = {};
// final Map<String, RxBool> playingMap = {};

final Map<String, RxBool> pausedMap = {};
String? _currentlyPlayingId;
final Map<String, FlutterSoundPlayer> audioPlayers = {};


  ChatController({
    required this.orderId,
    required this.mySenderType,
    DeliveryAuthApis? api,
    ChatSocketService? socket,
  })  : _api = api ?? Get.find<DeliveryAuthApis>(),
        _socket = socket ?? ChatSocketService();

  @override
  void onInit() async{
    super.onInit();
    _initRecorder();
    _loadHistory();
    _connectSocket();
    await _player.openPlayer();

    
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> _loadHistory() async {
    isLoading.value = true;
    try {
      final hist = await _api.fetchHistory(orderId);
      messages.assignAll(hist);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chat history');
    } finally {
      isLoading.value = false;
    }
  }

  void _connectSocket() async {
    final token = await DeliveryAuthApis.getToken();

    _socket.onMessage = _handleIncoming;
    _socket.onTyping = _handleTyping;
    _socket.onDone = () {
      isConnected.value = false;
      Get.snackbar('Disconnected', 'WebSocket connection closed');
    };
    _socket.onError = (err) {
      isConnected.value = false;
      Get.snackbar('WebSocket Error', err.toString());
    };

    _socket.connect(orderId: orderId, token: token);
    isConnected.value = true;
  }

void _handleIncoming(MessageModel msg) async {
  final idx = messages.indexWhere((m) => m.id == msg.id);

  if (msg.mediaType == MediaType.audio && msg.mediaUrl != null) {
    // Save audio file locally and assign its path
    final file = await getAudioFileFromInput(msg.mediaUrl!);
    msg.localPath = file!.path;

    print('📦 Incoming audio msg base64 length: ${msg.mediaUrl?.length}');
  }

  if (idx == -1) {
    final tempIdx = messages.indexWhere((m) =>
      m.isTemp &&
      m.text == msg.text &&
      m.senderType == msg.senderType &&
      (m.mediaType == null || m.mediaType == msg.mediaType)
    );

    if (tempIdx != -1) {
      messages[tempIdx] = msg;
    } else {
      messages.add(msg);
    }
  } else {
    messages[idx] = msg;
  }
}

// Future<File?> saveBase64AudioToFile(String base64Str) async {
//   try {
//     print('Decoding base64 audio...');
//     final bytes = base64Decode(base64Str.split(',').last);

//     final dir = await getTemporaryDirectory();
//     final filePath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

//     print('Saving to file: $filePath');
//     final file = File(filePath);
//     await file.writeAsBytes(bytes);

//     print('File saved successfully: ${file.path}');
//     return file;
//   } catch (e, stackTrace) {
//     print('Error saving base64 audio to file: $e');
//     print('Stack trace: $stackTrace');
//     return null;
//   }
// }


Future<File?> getAudioFileFromInput( input) async {
  try {
    // Case 1: It's likely a base64 string
    if (input.contains('base64,')) {
      print('🔍 Detected base64 input');
      try {
        // Strip data URL header
        final base64Data = input.split(',').last.trim().replaceAll('\n', '').replaceAll(' ', '');

        // Decode
        final bytes = base64Decode(base64Data);

        // Save to temp file
        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
        final file = File(path);
        await file.writeAsBytes(bytes);
        print('✅ Base64 audio saved to: ${file.path}');
        
        return file;
      } catch (e) {
        print('❌ Base64 decode failed: $e');
        return null;
      }
    }


    // Case 2: Remote URL
    if (input.startsWith('http')) {
      print('🌐 Detected remote URL: $input');
      final response = await http.get(Uri.parse(input));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final path = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

        final file = File(path);
        await file.writeAsBytes(response.bodyBytes);
        print('✅ Audio downloaded and saved to: ${file.path}');
        return file;
      } else {
        print('❌ Failed to download file. Status code: ${response.statusCode}');
        return null;
      }
    }

    // Case 3: Local File Path
    final file = File(input);
    if (await file.exists()) {
      print('📁 Using local file: ${file.path}');
      return file;
    } else {
      print('❌ Local file not found: $input');
      return null;
    }

  } catch (e, stackTrace) {
    print('❌ Error processing audio input: $e');
    print('🔍 Stack trace: $stackTrace');
    return null;
  }
}


  void _handleTyping(SenderType who, bool typing) {
    if (who != mySenderType) {
      remoteTyping.value = typing;
    }
  }

  void onInputChanged(String v) {
    isTyping.value = v.trim().isNotEmpty;
    _socket.sendTyping(
      orderId: orderId,
      senderType: mySenderType,
      isTyping: isTyping.value,
    );
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty || isSending.value) return;
    isSending.value = true;

    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    final tempMsg = MessageModel(
      id: tempId,
      orderId: orderId,
      text: text.trim(),
      senderType: mySenderType,
      timestamp: DateTime.now(),
      isTemp: true,
    );
    messages.add(tempMsg);

    try {
      if (!_socket.isConnected) {
        messages.removeWhere((m) => m.id == tempId);
        // Get.snackbar('Error', 'WebSocket not connected. Check your connection.');
        isSending.value = false;
        return;
      }

      _socket.sendText(
        orderId: orderId,
        message: text.trim(),
        senderType: mySenderType,
      );
      textController.clear();
      isTyping.value = false; // Reset typing status after sending
    } catch (e) {
      messages.removeWhere((m) => m.id == tempId);
      Get.snackbar('Error', 'Failed to send message: $e');
    } finally {
      isSending.value = false;
    }
  }

  Future<void> sendImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      await _sendMedia(file, MediaType.image);
    }
  }

  Future<void> startRecording() async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      Get.snackbar('Permission', 'Microphone permission denied');
      return;
    }

    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder.startRecorder(toFile: filePath);
    recordedPath = filePath;
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    await _recorder.stopRecorder();
    isRecording.value = false;

    if (recordedPath == null) return;

    final file = File(recordedPath!);
    if (await file.exists()) {
      await _sendMedia(file, MediaType.audio);
      // await file.delete();
    }

    recordedPath = null;
  }

 Future<void> _sendMedia(File file, MediaType type) async {
  final now = DateTime.now();
  final tempId = 'local-media-${now.millisecondsSinceEpoch}';

  final tempMsg = MessageModel(
    id: tempId,
    orderId: orderId,
    text:  '',
    senderType: mySenderType,
    timestamp: now,
    mediaUrl:file.path,
    localPath: file.path, // Store local path for audio
    mediaType: type,
    isTemp: true,
  );
  messages.add(tempMsg);

  try {
    final bytes = await file.readAsBytes();
    final base64Str = base64Encode(bytes);

    // Determine MIME type prefix
    String? mimePrefix;
    if (file.path.endsWith('.png')) {
      mimePrefix = 'data:image/png;base64,';
    } else if (file.path.endsWith('.jpg') || file.path.endsWith('.jpeg')) {
      mimePrefix = 'data:image/jpeg;base64,';
    } else if (file.path.endsWith('.mp3')) {
      mimePrefix = 'data:audio/mpeg;base64,';
    } else if (file.path.endsWith('.wav')) {
      mimePrefix = 'data:audio/wav;base64,';
    } else if (file.path.endsWith('.aac')) {
      mimePrefix = 'data:audio/aac;base64,';
    
    } else {
      throw Exception('Unsupported file type');
    }

    final base64WithPrefix = '$mimePrefix$base64Str';

    _socket.sendMediaBase64(
      orderId: orderId,
      mediaBase64: base64WithPrefix,
      mediaType: type,
      senderType: mySenderType,
      caption: tempMsg.text,
    );
  } catch (e) {
    messages.removeWhere((m) => m.id == tempId);
    Get.snackbar('Error', 'Media send error: $e');
  }
}

Future<void> playAudio(String path, String messageId) async {
  print('parthhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh....................$path');
  try {
   if (!_player.isOpen()) {
  await _player.openPlayer();
}
  } catch (e) {
    print('__________________________________________________________$e');
    // Player is probably already open
  }

  // Stop previous audio if another one is playing
  if (_currentlyPlayingId != null && _currentlyPlayingId != messageId) {
    await stopAudio();
  }

  _currentlyPlayingId = messageId;
  playingMap.putIfAbsent(messageId, () => true.obs);
  pausedMap.putIfAbsent(messageId, () => false.obs);
  audioPlayers[messageId] = _player;


  await _player.startPlayer(
    fromURI: path,
    // codec: Codec.defaultCodec,
    whenFinished: () {
      playingMap[messageId]?.value = false;
      pausedMap[messageId]?.value = false;
      _currentlyPlayingId = null;
    },
  );

  _positionSub = _player.onProgress?.listen((e) {
  positionMap.putIfAbsent(messageId, () => Duration.zero.obs);
  durationMap.putIfAbsent(messageId, () => Duration.zero.obs);

  positionMap[messageId]?.value = e.position;
  durationMap[messageId]?.value = e.duration;
});

  playingMap[messageId]?.value = true;
  pausedMap[messageId]?.value = false;
}


Future<void> pauseAudio(String messageId) async {
  await _player.pausePlayer();
  playingMap[messageId]?.value = false;
  pausedMap[messageId]?.value = true;
}

Future<void> resumeAudio(String messageId) async {
  await _player.resumePlayer();
  playingMap[messageId]?.value = true;
  pausedMap[messageId]?.value = false;
}

Future<void> stopAudio() async {
  await _player.stopPlayer();
  _positionSub?.cancel();
  _currentlyPlayingId = null;

  // Reset all
  playingMap.forEach((key, val) => val.value = false);
  pausedMap.forEach((key, val) => val.value = false);
}

// Future<String> saveBase64AudioToFile(String dataUrl, String fileName) async {
//    if (dataUrl == null || !dataUrl.contains(',')) {
//     throw Exception('Invalid base64 audio string');
//   }
//   // Remove the 'data:audio/aac;base64,' prefix
//   final base64String = dataUrl.split(',').last;

//   // Decode the base64
//   final bytes = base64Decode(base64String);

//   // Get temp directory
//   final dir = await getTemporaryDirectory();

//   // Save to file
//   final file = File('${dir.path}/$fileName.aac');
//   await file.writeAsBytes(bytes);

//   return file.path;
// }

void seekAudio(String messageId, Duration position) {
  final player = audioPlayers[messageId];
  if (player != null) {
    player.seekToPlayer(position);
  }
}


Rx<Duration> currentPosition(String messageId) =>
    positionMap[messageId] ?? Rx(Duration.zero);

Rx<Duration> totalDuration(String messageId) =>
    durationMap[messageId] ?? Rx(Duration.zero);


  Future<void> makeDirectCall(String phoneNumber) async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }
    if (status.isGranted) {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } else {
      Get.snackbar('Permission Denied', 'Phone call permission required');
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
        messages.clear();
        Get.back();
      },
    );
  }

  String formatGroupDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;

    if (diff == 0 &&
        now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      return 'Today';
    } else if (diff == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, y').format(date);
    }
  }

  @override
  void onClose() {
    textController.dispose();
    _recorder.closeRecorder();
    _socket.disconnect();
    _positionSub?.cancel();
_player.closePlayer();

    super.onClose();
  }
}
