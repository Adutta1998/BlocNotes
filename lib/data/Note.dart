class NoteFields{
  static String id="id";
  static String title="title";
  static String note="note";
  static String deleted="deleted";
  static String url="url";
}



class Note{
  String id;
  String title;
  String note;
  bool deleted;
  String? url;

  Note({
   required this.id,
   required this.title,
   required this.note,
   required this.deleted,
            this.url,
 });

  Note.fromJSON(Map json) :
        id=json["id"],
        title=json["title"],
        note=json["note"],
        deleted=(json["deleted"].runtimeType==int)?(json["deleted"]==0)?false:true:json["deleted"],
        url = json["url"];

  Map<String, Object?> toJson()=> {
    NoteFields.id:id,
    NoteFields.title:title,
    NoteFields.note:note,
    NoteFields.deleted:deleted?1:0,
    NoteFields.url:url
  };
}