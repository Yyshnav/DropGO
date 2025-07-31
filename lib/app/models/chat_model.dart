import 'package:intl/intl.dart';

enum SenderType { user, deliveryBoy, unknown }

SenderType senderTypeFromString(String? v) {
  switch (v?.toUpperCase()) {
    case 'DELIVERYBOY':
      return SenderType.deliveryBoy;
    case 'USER':
      return SenderType.user;
    default:
      return SenderType.unknown;
  }
}

String senderTypeToString(SenderType t) {
  switch (t) {
    case SenderType.deliveryBoy:
      return 'DELIVERYBOY';
    case SenderType.user:
      return 'USER';
    default:
      return 'UNKNOWN';
  }
}

enum MediaType { text, image, audio }

MediaType mediaTypeFromString(String? v) {
  switch (v?.toUpperCase()) {
    case 'IMAGE':
      return MediaType.image;
    case 'AUDIO':
      return MediaType.audio;
    case 'TEXT':
    default:
      return MediaType.text;
  }
}

String mediaTypeToString(MediaType t) {
  switch (t) {
    case MediaType.image:
      return 'IMAGE';
    case MediaType.audio:
      return 'AUDIO';
    case MediaType.text:
    default:
      return 'TEXT';
  }
}

class MessageModel {
  final String id;
  final String orderId;
  final String text;
  final SenderType senderType;
  final DateTime timestamp;
  final String? mediaUrl;
  String? localPath;
  final MediaType mediaType;
  final bool isTemp;

  MessageModel({
    required this.id,
    required this.orderId,
    required this.text,
    required this.senderType,
    required this.timestamp,
    this.mediaUrl,
    this.localPath,
    this.mediaType = MediaType.text,
    this.isTemp = false,
  });

  bool isMine(SenderType myType) => senderType == myType;

  String get timeString => DateFormat.Hm().format(timestamp);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: (json['id']?.toString() ?? ''),
      orderId: (json['order_id']?.toString() ?? json['orderId']?.toString() ?? ''),
      text: (json['text']?.toString() ?? ''),
      senderType: senderTypeFromString(json['sender_type']?.toString()),
      timestamp: DateTime.parse(json['timestamp']?.toString() ?? DateTime.now().toIso8601String()),
      mediaUrl: json['image']?.toString() ?? json['audio']?.toString(),
      localPath: null,
      mediaType: mediaTypeFromString(json['message_type']?.toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'text': text,
      'sender_type': senderTypeToString(senderType),
      'timestamp': timestamp.toIso8601String(),
      if (mediaType == MediaType.image) 'image': mediaUrl,
      if (mediaType == MediaType.audio) 'audio': mediaUrl,
      'message_type': mediaTypeToString(mediaType),
    };
  }

  MessageModel copyWith({
    String? id,
    String? text,
    SenderType? senderType,
    DateTime? timestamp,
    String? mediaUrl,
    String? localPath,
    MediaType? mediaType,
  }) {
    return MessageModel(
      id: id ?? this.id,
      orderId: orderId,
      text: text ?? this.text,
      senderType: senderType ?? this.senderType,
      timestamp: timestamp ?? this.timestamp,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      localPath: localPath ?? this.localPath,
      mediaType: mediaType ?? this.mediaType,
    );
  }
}
