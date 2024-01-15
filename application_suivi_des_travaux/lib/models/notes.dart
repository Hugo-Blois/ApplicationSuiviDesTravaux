class Notes {
  int? id;
  String? notes;

  Notes(this.id, this.notes);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notes': notes,
    };
  }

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(json['id'], json['notes']);
  }
}
