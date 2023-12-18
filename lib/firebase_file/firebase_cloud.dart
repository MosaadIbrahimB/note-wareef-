import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:not/model/data/note_data_model.dart';
import 'package:not/model/data/user_data_model.dart';

class FireBaseCloudControl {

  // add user in database
  static addUser(UserDataModel userOne) async {
    var createCollectionUser = FirebaseFirestore.instance.collection("user");

    createCollectionUser.add(UserDataModel.userDataModelToJson(userOne));
  }

  // add note in database
  static Future<DocumentReference> addNote(NoteDataModel not) async {
    var createCollectionNote = FirebaseFirestore.instance.collection("note");
    var add=await createCollectionNote.add(NoteDataModel.addNote(not));
  return add;
  }

  edaitNote(NoteDataModel not) async {
    var createCollectionNote = FirebaseFirestore.instance.collection("note");
    var edait=await createCollectionNote.doc(not.userId).update({});
  }




 static Future<void> getDataCurrentUser(List name) async {
    String currentId = FirebaseAuth.instance.currentUser!.uid;
    var getData = await FirebaseFirestore.instance
        .collection("user")
        .doc(currentId)
        .get();
    name.add(getData);
  }

}
