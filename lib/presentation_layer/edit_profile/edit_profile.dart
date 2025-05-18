import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_itsharks_25/data_layer/authentication/model/user_model.dart';
import 'package:chat_app_itsharks_25/presentation_layer/authentication/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../generated/l10n.dart';
import '../../logic_layer/app_cubit/app_cubit.dart';
import '../../logic_layer/auth_cubit/auth_cubit.dart';
import '../../logic_layer/settings_cubit/settings_cubit.dart';
import '../shared/styles/colors/app_colors.dart';
import '../shared/widgets/loading_widget.dart';
import '../shared/widgets/my_button.dart';
import '../shared/widgets/my_text_form_field.dart';

class EditProfile extends StatefulWidget {
  final UserModel userData;
  const EditProfile({super.key, required this.userData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.userData.email;
    _usernameController.text = widget.userData.username;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late PersistentBottomSheetController controller;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            AuthCubit.get(context).croppedFile = null;
            AuthCubit.get(context).pickedImage = null;
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          S.of(context).edit_profile_txt,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          var cubit = AuthCubit.get(context);
                          if (state is PickImageSuccessfully) {
                            cubit.cropImage();
                          }
                        },
                        builder: (context, state) {
                          var cubit = AuthCubit.get(context);
                          return CircleAvatar(
                            backgroundColor: AppColors.kPrimaryColor,
                            radius: 50,
                            child: CircleAvatar(
                              radius: 49,
                              backgroundImage: cubit.croppedFile == null
                                  ? CachedNetworkImageProvider(
                                      widget.userData.imageUrl,
                                    )
                                  : FileImage(
                                      File(cubit.croppedFile!.path),
                                    ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            controller =
                                _scaffoldKey.currentState!.showBottomSheet(
                              (context) {
                                var cubit = AuthCubit.get(context);
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6),
                                      topLeft: Radius.circular(6),
                                    ),
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: width / 2,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Permission.photos
                                                .request()
                                                .then((value) {
                                              if (value.isGranted) {
                                                cubit.pickImage("gallery");
                                                controller.close();
                                              }
                                            });
                                          },
                                          child: Text(
                                            S.of(context).gallery_txt,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors
                                                        .kPrimaryColor),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Permission.camera
                                                .request()
                                                .then((value) {
                                              if (value.isGranted) {
                                                cubit.pickImage("camera");
                                                controller.close();
                                              }
                                            });
                                          },
                                          child: Text(
                                            S.of(context).camera_txt,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors
                                                        .kPrimaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.kPrimaryColor,
                            child: BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                MyTextFormField(
                  validator: (p0) {},
                  controller: _emailController,
                  hintText: "example@gmail.com",
                  enabled: false,
                  prefixIcon: FontAwesomeIcons.envelope,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                MyTextFormField(
                  validator: (p0) {},
                  controller: _usernameController,
                  hintText: S.of(context).username_txt,
                  prefixIcon: FontAwesomeIcons.person,
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                SizedBox(
                  height: height * 0.055,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (_, state) {
                    if (state is UpdateUserSuccessfully) {
                      const snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Updated Successfully',
                          message: 'Your data have been updated successfully',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      AppCubit.get(context).getUser();
                      /*Navigator.pop(context);*/
                    }
                    if (state is UpdateUserError) {
                      const snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Update Error',
                          message:
                              'Your data have not updated successfully , try again later',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    if (state is UpdateUserLoading) {
                      return const LoadingWidget();
                    }
                    return MyButton(
                      onPressed: () {
                        UserModel user = AppCubit.get(context).user!;
                        user.username = _usernameController.text;

                        cubit.updateUserData(user: user);
                      },
                      text: "Save",
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is DeleteUserSuccess) {
                      const snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'User Deleted',
                          message: 'User deleted successfully',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteUserLoading) {
                      return const LoadingWidget();
                    }
                    return MyButton(
                      bgColor: AppColors.kDangerColor,
                      onPressed: () {
                        _scaffoldKey.currentState!.showBottomSheet(
                          (context) {
                            return Container(
                              color: SettingsCubit.get(context).isDark ?
                              Colors.black:Colors.white,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  MyTextFormField(
                                    hintText: "Confirm by password",
                                    controller: _passwordController,
                                    prefixIcon: FontAwesomeIcons.lock,
                                    validator: (p0) {},
                                    isPassword: true,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  MyButton(
                                    text: "Delete",
                                    onPressed: () {
                                      AuthCubit.get(context).deleteUser(widget.userData.id, widget.userData.email, _passwordController.text);
                                      Navigator.pop(context);
                                    },
                                    bgColor: AppColors.kDangerColor,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      text: "Delete",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
