import 'dart:io';

import 'package:chat_app_itsharks_25/logic_layer/auth_cubit/auth_cubit.dart';
import 'package:chat_app_itsharks_25/presentation_layer/layout/main_layout.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_auth_buttons/res/buttons/facebook_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/github_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';
import 'package:social_auth_buttons/res/shared/auth_button_style.dart';

import '../../../generated/l10n.dart';
import '../../../logic_layer/app_cubit/app_cubit.dart';
import '../../../utlis/app_functions.dart';
import '../../shared/styles/colors/app_colors.dart';
import '../../shared/widgets/auth_info.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_form_field.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (S.of(context).register_txt).toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 50.0),
                  ),
                  Text(
                    S.of(context).register_sub_txt,
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                  SizedBox(
                    height: height * 0.055,
                  ),
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
                                    ? const AssetImage(
                                        "assets/images/default.jpg")
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
                                  var cubit = AuthCubit.get(context);
                                  return Icon(
                                    cubit.croppedFile == null
                                        ? Icons.add
                                        : Icons.edit,
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
                    prefixIcon: FontAwesomeIcons.envelope,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextFormField(
                    validator: (p0) {},
                    controller: _usernameController,
                    hintText:S.of(context).username_txt,
                    prefixIcon: FontAwesomeIcons.person,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextFormField(
                    validator: (p0) {},
                    controller: _passwordController,
                    hintText: S.of(context).password_hint,
                    prefixIcon: FontAwesomeIcons.lock,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  MyTextFormField(
                    validator: (p0) {},
                    controller: _confirmationPasswordController,
                    hintText:S.of(context).confirm_password_txt,
                    prefixIcon: FontAwesomeIcons.lock,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: height * 0.055,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is RegisterSuccessfully) {
                        AppCubit.get(context).getUser();
                        navigateToReplacement(
                            context,
                            const MainLayout()
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const LoadingWidget();
                      }
                      return MyButton(
                        onPressed: () {
                          AuthCubit.get(context).register(
                            registerProvider: "email",
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordController.text);
                        },
                        text: S.of(context).register_txt,
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Center(
                    child: Text(
                      S.of(context).or_txt,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  SizedBox(
                    width: width,
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GoogleAuthButton(
                          onPressed: () {
                            AuthCubit.get(context).register(
                                registerProvider: "google",
                            );
                          },
                          elevation: 1.0,
                          borderRadius: 6.0,
                          darkMode: false,
                          style: AuthButtonStyle.icon,
                          width: 55,
                          height: 55,
                        ),
                        GithubAuthButton(
                          onPressed: () {},
                          elevation: 1.0,
                          borderRadius: 6.0,
                          darkMode: false,
                          style: AuthButtonStyle.icon,
                          width: 55,
                          height: 55,
                        ),
                        FacebookAuthButton(
                          onPressed: () {},
                          elevation: 1.0,
                          borderRadius: 6.0,
                          style: AuthButtonStyle.icon,
                          darkMode: false,
                          width: 55,
                          height: 55,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  AuthenticationInfo(
                    hintText: S.of(context).already_have_acc_txt,
                    buttonFunction: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    },
                    buttonText:S.of(context).login_txt,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
