class LocationModel {
  int? id;
  final String? address;
  final String? city;
  final String? state;
  final double? latitude;
  final double? longitude;

  LocationModel({
    this.id,
    this.address,
    this.city,
    this.state,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (state != null) {
      result.addAll({'state': state});
    }
    if (latitude != null) {
      result.addAll({'latitude': latitude});
    }
    if (longitude != null) {
      result.addAll({'longitude': longitude});
    }

    return result;
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id']?.toInt(),
      address: map['address'],
      city: map['city'],
      state: map['state'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
    );
  }
}
