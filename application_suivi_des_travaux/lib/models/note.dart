class Note {
  int? id;
  String? notes;

  Note(this.id, this.notes);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notes': notes,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(json['id'], json['notes']);
  }
}
