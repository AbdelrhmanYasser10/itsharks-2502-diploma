class UserModel{
  late String id;
  late String username;
  late String email;
  late String imageUrl;
  late String? fcmToken;

  UserModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    username= json["username"];
    email = json["email"];
    imageUrl = json["imageUrl"] ?? "https://img.freepik.com/free-psd/contact-icon-illustration-isolated_23-2151903337.jpg?semt=ais_hybrid&w=740";
    fcmToken = json["fcmToken"];
  }

  Map<String,dynamic> toJson ()=>{
    "id":id,
    "username":username,
    "email":email,
    "imageUrl":imageUrl,
    "fcmToken":fcmToken,
  };

}