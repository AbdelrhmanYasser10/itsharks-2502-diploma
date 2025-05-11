class UserModel{
  late String id;
  late String username;
  late String email;
  late String imageUrl;

  UserModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    username= json["username"];
    email = json["email"];
    imageUrl = json["imageUrl"];
  }

  Map<String,dynamic> toJson ()=>{
    "id":id,
    "username":username,
    "email":email,
    "imageUrl":imageUrl,
  };

}