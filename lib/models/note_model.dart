class NoteModel{

  int? id;
  String? title;
  String? description;
  String? date;
  int? status;
  int? isFav;

  NoteModel({
    this.id,
    this.status,
    this.isFav,
    this.description,
    this.title,
    this.date
  });

  /// Constructor
  factory NoteModel.fromMap(Map<String,dynamic> map){
    return NoteModel(
      title: map['title'],
      id: map['id'],
      date:map["date"],
      isFav: map["isFav"],
      status: map['status'],
      description: map["desc"],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "title":title,
      "id":id,
      "desc":description,
      "date":date,
      "isFav":isFav,
      "status":status,
    };
  }
}