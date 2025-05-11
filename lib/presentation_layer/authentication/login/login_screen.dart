import 'package:authentication_buttons/authentication_buttons.dart';
import 'package:chat_app_itsharks_25/presentation_layer/authentication/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_auth_buttons/res/buttons/facebook_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/github_auth_button.dart';
import 'package:social_auth_buttons/res/buttons/google_auth_button.dart';
import 'package:social_auth_buttons/res/shared/auth_button_style.dart';
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
                  "LOGIN",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontSize: 50.0),
                ),
                Text(
                  "login to chat with your friends",
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
                  hintText: "Password",
                  prefixIcon: FontAwesomeIcons.lock,
                  isPassword: true,
                ),
                SizedBox(
                  height: height * 0.055,
                ),
                MyButton(
                  onPressed: () {},
                  text: "Login",
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Center(
                  child: Text(
                    "OR",
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
                        onPressed: () {},
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
                  hintText: "Don't have an account?",
                  buttonFunction:(){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const RegisterScreen()));
                  } ,
                  buttonText: "Signup",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
