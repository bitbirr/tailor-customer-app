class Customer {
  const Customer({
    required this.id,
    required this.displayName,
    this.phone,
    this.email,
    this.address,
    this.photoPath,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
    this.revision = 1,
  });

  final String id;
  final String displayName;
  final String? phone;
  final String? email;
  final String? address;
  final String? photoPath;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  final int revision;

  bool get isDeleted => deletedAtMs != null;

  Customer copyWith({
    String? displayName,
    String? phone,
    String? email,
    String? address,
    String? photoPath,
    int? updatedAtMs,
    int? deletedAtMs,
    int? revision,
    bool clearPhone = false,
    bool clearEmail = false,
    bool clearAddress = false,
    bool clearPhoto = false,
  }) {
    return Customer(
      id: id,
      displayName: displayName ?? this.displayName,
      phone: clearPhone ? null : (phone ?? this.phone),
      email: clearEmail ? null : (email ?? this.email),
      address: clearAddress ? null : (address ?? this.address),
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      createdAtMs: createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      revision: revision ?? this.revision,
    );
  }
}
