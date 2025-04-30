import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce_it_sharks/screen/register_screen.dart';
import 'package:e_commerce_it_sharks/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_commerce_it_sharks/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_it_sharks/shared/functions/validators.dart';
import 'package:e_commerce_it_sharks/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../layout/main_layout.dart';
import '../shared/functions/functions.dart';
import '../shared/styles/colors.dart';
import '../shared/styles/text_styles.dart';
import '../shared/widgets/auth_info.dart';
import '../shared/widgets/my_button.dart';
import '../shared/widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: AppTextStyles.headlineTextStyle,
              ),
              Text(
                "Login to see our special offers",
                style: AppTextStyles.subTitleTextStyle,
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _emailController,
                labelText: "Email",
                icon: FontAwesomeIcons.envelope,
                validatorFunction: emailValidator,
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _passwordController,
                labelText: "Password",
                isPassword: true,
                icon: FontAwesomeIcons.lock,
                validatorFunction: passwordValidator,
              ),
              const SizedBox(
                height: 50.0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccessfully) {
                    showFeedBackForUser(
                      title: "Successfully",
                      message: "Login Successfully",
                      context: context,
                      type: ContentType.success,
                    );

                    //Cache for user token
                    AppCubit.get(context).getProfile(state.token);
                    //Navigation
                    navigateToReplacement(context, const MainLayout());
                  }
                  if (state is LoginWithError) {
                    showFeedBackForUser(
                      title: "Error",
                      message: state.message,
                      context: context,
                      type: ContentType.failure,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const LoadingWidget();
                  }
                  return MyButton(
                    text: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthCubit.get(context).login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              AuthenticationInfo(
                hintText: "Don't have an account?",
                buttonText: "Register",
                buttonFunction: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const RegisterScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
