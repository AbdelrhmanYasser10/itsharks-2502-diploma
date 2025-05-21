import 'package:authentication_buttons/authentication_buttons.dart';
import 'package:chat_app_itsharks_25/logic_layer/app_cubit/app_cubit.dart';
import 'package:chat_app_itsharks_25/logic_layer/auth_cubit/auth_cubit.dart';
import 'package:chat_app_itsharks_25/presentation_layer/authentication/register/register_screen.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_auth_buttons/res/buttons/facebook_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/github_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';
import 'package:social_auth_buttons/res/shared/auth_button_style.dart';
import '../../../generated/l10n.dart';
import '../../../utlis/app_functions.dart';
import '../../layout/main_layout.dart';
import '../../shared/widgets/auth_info.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (S.of(context).login_txt).toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 50.0),
                ),
                Text(
                 S.of(context).login_subtitle,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
                SizedBox(
                  height: height * 0.055,
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
                  controller: _passwordController,
                  hintText: S.of(context).password_hint,
                  prefixIcon: FontAwesomeIcons.lock,
                  isPassword: true,
                ),
                SizedBox(
                  height: height * 0.055,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is LoginSuccessfully){
                      AppCubit.get(context).getUser();
                      navigateToReplacement(
                        context,
                        const MainLayout()
                      );
                    }
                  },
                  builder: (context, state) {
                    var cubit = AuthCubit.get(context);
                    if(state is LoginLoading){
                      return const LoadingWidget();
                    }
                    return MyButton(
                      onPressed: () {
                        cubit.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                        );
                      },
                      text: S.of(context).login_txt,
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
                  hintText:S.of(context).dont_have_acc,
                  buttonFunction: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterScreen()));
                  },
                  buttonText: S.of(context).signup_txt,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
