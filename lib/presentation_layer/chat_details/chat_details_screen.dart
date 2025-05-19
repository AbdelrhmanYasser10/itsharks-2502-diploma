import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_itsharks_25/data_layer/authentication/model/user_model.dart';
import 'package:chat_app_itsharks_25/logic_layer/app_cubit/app_cubit.dart';
import 'package:chat_app_itsharks_25/logic_layer/settings_cubit/settings_cubit.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/styles/text_styles/text_styles.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/widgets/loading_widget.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/widgets/my_text_form_field.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/bubbles/bubble_special_two.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../shared/styles/colors/app_colors.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserModel reciever;
  const ChatDetailsScreen({super.key, required this.reciever});

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getAllMessages(revieverId: widget.reciever.id);
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  widget.reciever.imageUrl,
                ),
                radius: 20,
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                widget.reciever.username,
                style: SettingsCubit.get(context).isDark
                    ? AppTextStyles.font16WhiteBold
                    : AppTextStyles.font16BlackBold,
              )
            ],
          ),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {
                  if (state is SendingMessageSuccessfully) {
                    _messageController.clear();
                  }
                },
                builder: (context, state) {
                  if (state is GetAllMessagesLoading) {
                    return const LoadingWidget();
                  }
                  var cubit = AppCubit.get(context);
                  return ListView.builder(
                    itemBuilder: (context, index) =>
                        buildChatComponent(index, cubit, context),
                    itemCount: cubit.allMessages.length + 1,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  BlocConsumer<AppCubit, AppState>(
                    listener: (context, state) {
                      var cubit = AppCubit.get(context);

                      if (state is GetImageSuccessfully) {
                        cubit.cropImage();
                      }
                    },
                    builder: (context, state) {
                      var cubit = AppCubit.get(context);
                      if (cubit.croppedImage == null) {
                        return const SizedBox();
                      }
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                          color: SettingsCubit.get(context).isDark
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: const Border(
                            top: BorderSide(
                              width: 1,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(
                                    cubit.croppedImage!.path,
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  cubit.croppedImage!.path.split("/").last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.font16WhiteBold.copyWith(
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ),
                              (state is UploadImageLoading)
                                  ? const LoadingWidget()
                                  : IconButton(
                                      onPressed: () =>
                                          cubit.clearImageFromMem(),
                                      icon: const Icon(
                                        Icons.close,
                                        color: AppColors.kPrimaryColor,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          hintText: S.of(context).enter_message_txt,
                          controller: _messageController,
                          prefixIcon: FontAwesomeIcons.message,
                          isMessageField: true,
                          scaffoldKey: _scaffoldKey,
                          validator: (p0) {
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if ((await Connectivity().checkConnectivity())
                              .isNotEmpty) {
                            if (_messageController.text.isNotEmpty) {
                              if (AppCubit.get(context).croppedImage == null) {
                                AppCubit.get(context).sendMessage(
                                  content: _messageController.text,
                                  reciever: widget.reciever
                                );
                                _messageController.clear();
                              } else {
                                AppCubit.get(context).uploadImage(
                                  content: _messageController.text,
                                  reciever: widget.reciever,
                                );
                              }
                            }
                          } else {
                            var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: S.of(context).sending_err_txt,
                                message: S.of(context).check_internet_conn_txt,
                                contentType: ContentType.failure,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildChatComponent(int index, AppCubit cubit, BuildContext context) {
    bool isInList = (index < cubit.allMessages.length);
    bool isOutOfRange = (index == cubit.allMessages.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            if(isInList)
              messageComponent(
                cubit.allMessages[index].content,
                cubit.user!.id == cubit.allMessages[index].senderId,
                SettingsCubit.get(context).isDark,
              )
            else
              const SizedBox(),
          if(isInList)
                if(cubit.allMessages[index].media != null)
                  BubbleNormalImage(
                    id: cubit.allMessages[index].media!,
                    image: CachedNetworkImage(
                        imageUrl: cubit.allMessages[index].media!),
                    color: AppColors.kPrimaryColor,
                    tail: false,
                    isSender:
                        cubit.user!.id == cubit.allMessages[index].senderId,
                  )
                else
                  const SizedBox()
           else
             const SizedBox(),
            if(isOutOfRange)
              BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is UploadImageLoading) {
                    return const LoadingWidget();
                  }
                  if (state is UploadImageError) {
                    return GestureDetector(
                      onTap: () async {
                        if ((await Connectivity().checkConnectivity())
                            .isNotEmpty) {
                          if (_messageController.text.isNotEmpty) {
                            AppCubit.get(context).uploadImage(
                              content: _messageController.text,
                              reciever: widget.reciever,
                            );
                          }
                        } else {
                          var snackBar = SnackBar(
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            content: AwesomeSnackbarContent(
                              title: S.of(context).sending_err_txt,
                              message: S.of(context).check_internet_conn_txt,
                              contentType: ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        }
                      },
                      child: BubbleSpecialThree(
                        text: "retry",
                        color: AppColors.kDangerColor,
                        textStyle: AppTextStyles.font16WhiteBold,
                        tail: false,
                        isSender: true,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              )
            else
              const SizedBox(),
      ],
    );
  }

  Widget messageComponent (String messageContent, bool isMeSender,bool isDark){
    bool isArabic = Intl.getCurrentLocale() == "ar";
    if(isArabic) {
      return Row(
        mainAxisAlignment: (isArabic && isMeSender) ?
        MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          BubbleSpecialThree(
            text: messageContent,
            color:
            isMeSender ?
            AppColors.kPrimaryColor
                :
            isDark
                ? Colors.white
                : Colors.black,
            textStyle: AppTextStyles.font16WhiteBold.copyWith(
                color: (isDark && isMeSender)
                    ? Colors.black
                    : null),
            tail: false,
            isSender: isMeSender,
          ),
        ],
      );
    }
    else{
      return BubbleSpecialThree(
        text: messageContent,
        color:
        isMeSender?
        AppColors.kPrimaryColor
            :
        isDark
            ? Colors.white
            : Colors.black,
        textStyle: AppTextStyles.font16WhiteBold.copyWith(
            color: (isDark && isMeSender)
                ? Colors.black
                : null),
        tail: false,
        isSender: isMeSender,
      );
    }
  }
}
