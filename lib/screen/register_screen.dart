import 'package:e_commerce_it_sharks/shared/styles/colors.dart';
import 'package:e_commerce_it_sharks/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/widgets/auth_info.dart';
import '../shared/widgets/my_button.dart';
import '../shared/widgets/my_text_form_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
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
                controller: TextEditingController(),
                labelText: "Email",
                icon: FontAwesomeIcons.envelope,
                validatorFunction: (email) {
                    if(email == null || email.isEmpty){
                      return "Email cannot be empty";
                    }
                    else{
                      RegExp expression = RegExp("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$");
                      if(!expression.hasMatch(email)){
                        return "Enter a valid email";
                      }
                    }

                    return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: TextEditingController(),
                labelText: "Username",
                icon: FontAwesomeIcons.user,
                validatorFunction: (value) {
                    if(value == null || value.isEmpty){
                      return "Username cannot be empty";
                    }
                    return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: TextEditingController(),
                labelText: "Phone Number",
                icon: FontAwesomeIcons.phone,
                validatorFunction: (value) {
                    if(value == null||value.isEmpty ){
                      return "Phone number cannot be empty";
                    }
                    else if(value.length != 11){
                      return "Phone must contain 11 number";
                    }
                    try{
                      int.parse(value);
                    }catch(error){
                      return "Phone must contain numbers only";
                    }
                    return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: TextEditingController(),
                labelText: "Password",
                icon: FontAwesomeIcons.lock,
                validatorFunction: (password) {
                  RegExp expression = RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\$!%*?&])[A-Za-z\\d@\$!%*?&]{8,10}\$");
                  if(password == null || password.isEmpty){
                    return "Password cannot be empty";
                  }
                  else if(!expression.hasMatch(password)){
                    return "Enter a valid password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextFormField(
                controller: TextEditingController(),
                labelText: "Confirm Password",
                icon: FontAwesomeIcons.lock,
                validatorFunction: (p0) {

                },
              ),
              const SizedBox(
                height: 50.0,
              ),

              MyButton(
                text: "Register",
                onPressed: (){
                  if(_formKey.currentState!.validate()){}
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              AuthenticationInfo(
                hintText: "Already have an account?",
                buttonText: "Login",
                buttonFunction: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



