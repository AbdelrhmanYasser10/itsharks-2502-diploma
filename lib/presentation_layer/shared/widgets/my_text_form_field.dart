import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';
import '../../../logic_layer/app_cubit/app_cubit.dart';
import '../../../logic_layer/settings_cubit/settings_cubit.dart';
import '../styles/colors/app_colors.dart';

class MyTextFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String?Function(String?) validator;
  final bool isPassword;
  final bool isMessageField;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool enabled;
  const MyTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    required this.validator,
    this.isPassword = false,
    this.enabled = true,
    this.isMessageField = false,
    this.scaffoldKey,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  late bool isSecure;
  final FocusNode _focusNode = FocusNode();
  bool _isFoucs = false;
  late PersistentBottomSheetController controller;
  @override
  void initState() {
    super.initState();
    isSecure = widget.isPassword;
    _focusNode.addListener((){
      setState(() {
        print(_focusNode.hasFocus);
        _isFoucs = _focusNode.hasFocus;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
  listener: (context, state) {},
  builder: (context, state) {
    var width = MediaQuery.of(context).size.width;
    var cubit = SettingsCubit.get(context);
    return TextFormField(
      enabled: widget.enabled,
      focusNode: _focusNode,
      obscureText: isSecure,
      controller: widget.controller,
      cursorColor: AppColors.kPrimaryColor,
      validator: widget.validator,
      decoration:InputDecoration(
        suffixIcon: widget.isPassword ? IconButton(
            onPressed: (){
              setState(() {
                isSecure = !isSecure;
              });
            },
            icon: Icon(
              isSecure ? FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,
              color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,

            ),
        ):widget.isMessageField ? IconButton(
            onPressed: (){
              controller = widget.scaffoldKey!.currentState!.showBottomSheet(
                  (context){
                    var cubit = AppCubit.get(context);
                    return Container(
                      decoration:  BoxDecoration(
                        color: SettingsCubit.get(context).isDark ? Colors.black:
                        Colors.white,
                        borderRadius: const BorderRadius.only(
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
                                    cubit.getImage("gallery");
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
                                    cubit.getImage("camera");
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
                  }
              );
            },
            icon: Icon(
              FontAwesomeIcons.link,
              color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,
            ),
        ) : null,
          filled: true,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,
          ),
          fillColor: cubit.isDark?Colors.black:Colors.white,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: _isFoucs?AppColors.kPrimaryColor :Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.grey,
              )
          ) ,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.kDangerColor,
              )
          ) ,
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.kPrimaryColor,
              )
          ) ,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey,
              )
          )
      ),
    );
  },
);
  }

/*  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
    _focusNode.removeListener((){});
    _focusNode.dispose();
  }*/
}
