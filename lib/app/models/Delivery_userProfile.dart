class DeliveryUser {
  final String name;
  final String email;
  final String phone;
  final String? image; // <-- new field

  DeliveryUser({
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });

  factory DeliveryUser.fromJson(Map<String, dynamic> json) {
    return DeliveryUser(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'], // <-- parse image if available
    );
  }

  DeliveryUser copyWith({
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    return DeliveryUser(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };
  }
}
