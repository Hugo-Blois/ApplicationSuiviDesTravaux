enum Traffic { slow, deviated }

class Travaux {
  int? id;
  String? titre;
  String? description;
  String? address;
  String? startAt;
  String? endAt;
  String? traffic;
  String? contact;
  String? email;
  int? isTramway;
  double? long;
  double? lat;

  Travaux(
      {this.id,
      this.titre,
      this.description,
      this.address,
      this.startAt,
      this.endAt,
      this.traffic,
      this.contact,
      this.email,
      this.isTramway,
      this.long,
      this.lat});
}
