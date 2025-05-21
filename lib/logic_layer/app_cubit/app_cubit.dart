import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app_itsharks_25/data_layer/authentication/model/user_model.dart';
import 'package:chat_app_itsharks_25/data_layer/messages/message_model.dart';
import 'package:chat_app_itsharks_25/services/notification_serivces/messaging_config.dart';
import 'package:chat_app_itsharks_25/services/notification_serivces/send_notification_serivce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../data_layer/authentication/user_repository/user_repo.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final UserRepository userRepo;
  AppCubit({
    required  this.userRepo,
}) : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);

  UserModel? user;
  List<UserModel> allUsers = [];
  List<MessageModel> allMessages = [];
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();
  XFile? pickedImage;
  CroppedFile? croppedImage;

  final cloudinary = Cloudinary.signedConfig(
    apiKey: "759286832413946",
    apiSecret: "_I6skpHGJeC2DIAVXMkcHh6MU7s",
    cloudName: "ddksmtpkd",
  );

  final _database = FirebaseFirestore.instance;

  void getUser()async{
    emit(GetUserDataLoading());
    try {
      user = await userRepo.getUserModelFromWebService();
      user!.fcmToken = MessagingConfiguration.getFCMToken();
      emit(GetUserDataSuccessfully());
    }catch(error){
      emit(GetUserDataError());
    }
  }

  void getAllUsers(){
    emit(GetAllUserDataLoading());
    _database.
    collection("users")
        .snapshots()
        .listen((event){
        allUsers.clear();
       for(var element in event.docs){
         UserModel currUser = UserModel.fromJson(element.data());
         if(currUser.id != FirebaseAuth.instance.currentUser!.uid){
           allUsers.add(currUser);
         }
       }
       emit(GetAllUserDataSuccessfully());
    }).onError((err){
      emit(GetAllUserDataError());
    });
  }

  void sendMessage({
  required String content,
    String?media,
    required UserModel reciever,
})async{
    MessageModel messageModel = MessageModel(
      date: Timestamp.now(),
      content: content,
      recieverId: reciever.id,
      media: media,
      senderId: user!.id,
    );

    emit(SendingMessageLoading());
    await _database
        .collection("users")
        .doc(user!.id)
        .collection("chats")
        .doc(reciever.id)
        .collection("messages")
        .add(messageModel.toJson());

    await _database
        .collection("users")
        .doc(reciever.id)
        .collection("chats")
        .doc(user!.id)
        .collection("messages")
        .add(messageModel.toJson());
    if(reciever.fcmToken !=null){
      await sendNotification(
          token: reciever.fcmToken!,
          title: reciever.username,
          body: content,
          data: {
            "route":"/chat_details",
            "user":jsonEncode(user!.toJson()),
          },
      );
    }
    emit(SendingMessageSuccessfully());
  }


  void getAllMessages({required String revieverId}){
    emit(GetAllMessagesLoading());

    _database
    .collection("users")
    .doc(user!.id)
    .collection("chats")
    .doc(revieverId)
    .collection("messages")
    .orderBy("date")
    .snapshots()
    .listen((event){
      allMessages.clear();
      for(var element in event.docs){
        var message = MessageModel.fromJson(element.data());
        allMessages.add(message);
      }
      emit(GetAllMessagesSuccesfully());
    }).onError((error){
      emit(GetAllMessagesError());
    });
  }


  void getImage(String source)async{
    if(source == "gallery"){
      pickedImage =await _picker.pickImage(source: ImageSource.gallery);

    }
    else{
      pickedImage =await _picker.pickImage(source: ImageSource.camera);
    }
    if(pickedImage == null){
      emit(GetImageError());
    }
    else{
      emit(GetImageSuccessfully());
    }
  }
  void cropImage()async{
    croppedImage = await _cropper.cropImage(sourcePath: pickedImage!.path);
    if(croppedImage == null){
      pickedImage = null;
      emit(CropImageError());
    }
    else{
      pickedImage =null;
      emit(CropImageSuccessfully());
    }
  }

  void clearImageFromMem(){
    croppedImage = null;
    emit(ClearImage());
  }


  void uploadImage({
 required String content,
    required UserModel reciever,
})async{
    emit(UploadImageLoading());

    final response = await
    cloudinary.upload
      (
      file: croppedImage!.path,
      fileBytes:  File(croppedImage!.path).readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: "User images - chat app",
      fileName: croppedImage!.path.split('/').last,
    );

    clearImageFromMem();
    if(response.isSuccessful){
      sendMessage(
          content: content,
          reciever: reciever,
          media: response.url,
      );
    }
    else{
      emit(UploadImageError());
    }
  }



}
