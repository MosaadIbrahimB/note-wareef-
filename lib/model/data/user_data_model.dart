class UserDataModel{
  String name;
  String email;

  UserDataModel({required this.name, required this.email});

 static Map<String,dynamic> userDataModelToJson(UserDataModel userDataModel){
    return{
      "name":userDataModel.name,
      "email":userDataModel.email
    };
  }



}