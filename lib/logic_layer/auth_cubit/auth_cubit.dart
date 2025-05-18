import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../data_layer/authentication/model/user_model.dart';
import '../../presentation_layer/shared/styles/colors/app_colors.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  CroppedFile? croppedFile;

  final _auth = FirebaseAuth.instance;

  final _database = FirebaseFirestore.instance;

  final cloudinary = Cloudinary.signedConfig(
    apiKey: "759286832413946",
    apiSecret: "_I6skpHGJeC2DIAVXMkcHh6MU7s",
    cloudName: "ddksmtpkd",
  );
  void pickImage(String source) async {
    if (source == "camera") {
      pickedImage = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedImage = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedImage == null) {
      emit(PickImageError());
    } else {
      emit(PickImageSuccessfully());
    }
  }

  void cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Edit Image',
          toolbarColor: AppColors.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Edit Image',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
    if (croppedFile == null) {
      emit(CropImageError());
    } else {
      emit(CropImageSuccessfully());
    }
  }

  void register({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(RegisterLoading());
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final response = await cloudinary.upload(
      file: croppedFile!.path,
      fileBytes: File(croppedFile!.path).readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: "User images - chat app",
      fileName: croppedFile!.path.split('/').last,
    );

    if (response.isSuccessful) {
      await _database.collection("users").doc(userCredential.user!.uid).set({
        "id": userCredential.user!.uid,
        "username": username,
        "imageUrl": response.url!,
        "email": email,
      });
      croppedFile = null;
      pickedImage = null;
      emit(RegisterSuccessfully());
    } else {
      emit(RegisterError());
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        emit(LoginSuccessfully());
      } else {
        emit(LoginError());
      }
    } catch (error) {
      emit(LoginError());
    }
  }

  void updateUserData({
    required UserModel user,
  }) async {
    emit(UpdateUserLoading());
    if (croppedFile != null) {
      final response = await cloudinary.upload(
        file: croppedFile!.path,
        fileBytes: File(croppedFile!.path).readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: "User images - chat app",
        fileName: croppedFile!.path.split('/').last,
      );
      if (response.isSuccessful) {
        user.imageUrl = response.url!;
        croppedFile = null;
        pickedImage =null;
        await _database.collection("users").doc(user.id).set(user.toJson());
        emit(UpdateUserSuccessfully());
      }
      else{
        emit(UpdateUserError());
      }

    }
    await _database.collection("users").doc(user.id).set(user.toJson());
    emit(UpdateUserSuccessfully());
  }

  void deleteUser(String userId,String email ,String password)async {
    emit(DeleteUserLoading());
    // Create a credential
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await _auth.currentUser!.reauthenticateWithCredential(credential);
    await _auth.currentUser!.delete();
    await _database.collection(
      "users"
    ).doc(userId).delete();
    emit(DeleteUserSuccess());
  }
}
