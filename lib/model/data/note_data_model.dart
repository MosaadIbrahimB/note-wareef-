class NoteDataModel {
  int date;
  String title;
  String type;
  String desc;
  String image;
  String userId;

  NoteDataModel(
      {
        required this.date,
        required this.userId,
      required this.title,
      required this.type,
      required this.desc,
      required this.image});



 static Map<String,dynamic> addNote(NoteDataModel n){
    return{
      "date":n.date,
      "type":n.type,
      "title":n.title,
      "desc":n.desc,
      "image":n.image,
      "userId":n.userId,
    };
  }

}
