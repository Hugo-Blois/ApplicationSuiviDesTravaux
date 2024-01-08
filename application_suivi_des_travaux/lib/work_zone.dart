class WorkZone {
  final int id;
  final String title;
  final String description;
  final String address;
  final DateTime startAt;
  final DateTime endAt;
  final String traffic;
  final String contact;
  final String email;
  final Location location;

  WorkZone({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.startAt,
    required this.endAt,
    required this.traffic,
    required this.contact,
    required this.email,
    required this.location,
  });

  factory WorkZone.fromJson(Map<String, dynamic> json) {
    return WorkZone(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      address: json['address'],
      startAt: DateTime.parse(json['startat']),
      endAt: DateTime.parse(json['endat']),
      traffic: json['traffic'],
      contact: json['contact'],
      email: json['email'],
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final List<double> coordinates;

  Location({required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['geometry']['coordinates']),
    );
  }
}
