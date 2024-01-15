enum Etat { finished, unfinished }

class Note {
  int? id;
  String? notes;
  Etat etat;

  Note(this.id, this.notes, this.etat);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notes': notes,
      'etat': etat,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(json['id'], json['notes'], json['etat']);
  }
}
