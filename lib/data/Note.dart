class Note{
  String id;
  String title;
  String note;
  bool deleted;

  Note({
   required this.id,
   required this.title,
   required this.note,
   required this.deleted,
 });

  Note.fromJSON(Map json) :
        id=json["id"],
        title=json["title"],
        note=json["note"],
        deleted=json["deleted"];
}