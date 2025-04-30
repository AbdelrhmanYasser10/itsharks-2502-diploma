import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:e_commerce_it_sharks/screen/login_screen.dart';
import 'package:e_commerce_it_sharks/shared/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_it_sharks/shared/styles/colors.dart';
import 'package:e_commerce_it_sharks/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../layout/main_layout.dart';
import '../shared/cubits/app_cubit/app_cubit.dart';
import '../shared/functions/functions.dart';
import '../shared/functions/validators.dart';
import '../shared/widgets/auth_info.dart';
import '../shared/widgets/loading_widget.dart';
import '../shared/widgets/my_button.dart';
import '../shared/widgets/my_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();

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
                "REGISTER",
                style: AppTextStyles.headlineTextStyle,
              ),
              Text(
                "Signup to see our special offers",
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
                controller: _usernameController,
                labelText: "Username",
                icon: FontAwesomeIcons.user,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _phoneNumberController,
                labelText: "Phone Number",
                icon: FontAwesomeIcons.phone,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone number cannot be empty";
                  } else if (value.length != 11) {
                    return "Phone must contain 11 number";
                  }
                  try {
                    int.parse(value);
                  } catch (error) {
                    return "Phone must contain numbers only";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _passwordController,
                labelText: "Password",
                isPassword:true,
                icon: FontAwesomeIcons.lock,
                validatorFunction: passwordValidator,
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: _confPasswordController,
                labelText: "Confirm Password",
                isPassword:true,
                icon: FontAwesomeIcons.lock,
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirmation cannot be empty";
                  } else {
                    if (_passwordController.text != value) {
                      return "Confirmation doesn't match the password";
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50.0,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterSuccessfully) {
                    showFeedBackForUser(
                      title: "Successfully",
                      message: "Registered Successfully",
                      context: context,
                      type: ContentType.success,
                    );

                    //Cache for user token
                    AppCubit.get(context).getProfile(state.token);
                    //Navigation
                    navigateToReplacement(context,const MainLayout());

                  }
                  if (state is RegisterWithError) {
                    showFeedBackForUser(
                      title: "Error",
                      message: state.message,
                      context: context,
                      type: ContentType.failure,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const LoadingWidget();
                  }
                  return MyButton(
                    text: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthCubit.get(context).register(
                          email: _emailController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                          phoneNumber: _phoneNumberController.text,
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
                hintText: "Already have an account?",
                buttonText: "Login",
                buttonFunction: () {
                  navigateToReplacement(context,const LoginScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
