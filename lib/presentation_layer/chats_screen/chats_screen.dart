import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_itsharks_25/logic_layer/app_cubit/app_cubit.dart';
import 'package:chat_app_itsharks_25/logic_layer/settings_cubit/settings_cubit.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/styles/text_styles/text_styles.dart';
import 'package:chat_app_itsharks_25/presentation_layer/shared/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chat_details/chat_details_screen.dart';
import '../shared/styles/colors/app_colors.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  Timer? timer;
  bool sendEmailLink = false;
  int minutes = 1;
  int seconds = 59;
  final _auth = FirebaseAuth.instance;

  void _startTimer() {
    setState(() {
      sendEmailLink = true;
    });
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          seconds --;
          if(seconds == 0){
            if(minutes > 0) {
              minutes--;
              seconds = 59;
            }
            else if(minutes == 0){
              setState(() {
                sendEmailLink = false;
                minutes = 1;
                seconds = 59;
              });
            }

          }
        });
      },
    );
    timer = Timer.periodic(
      const Duration(minutes: 1 , seconds: 58),
      (t)async {
        await _auth.currentUser?.reload();
        setState(() {
          if (_auth.currentUser!.emailVerified) {
            timer?.cancel();
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getAllUsers();

      return Scaffold(
        body: Column(
          children: [
            _auth.currentUser!.emailVerified
                ? const SizedBox()
                : Container(
                    width: double.infinity,
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Verify your email",
                              style: AppTextStyles.font16BlackBold,
                            ),
                          ),
                          (sendEmailLink && !_auth.currentUser!.emailVerified) ? Text(
                            "$minutes:$seconds",
                            style: AppTextStyles.font16BlackBold,
                          ):GestureDetector(
                            onTap: () async {
                              await _auth.currentUser!.sendEmailVerification();
                              _startTimer();
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: SnackBar(
                                      content: AwesomeSnackbarContent(
                                        title: "Check your email",
                                        titleTextStyle:
                                            AppTextStyles.font18WhiteBold,
                                        message:
                                            "Check your email to verify your account",
                                        messageTextStyle:
                                            AppTextStyles.font16WhiteBold,
                                        contentType: ContentType.warning,
                                      ),
                                    ),
                                  ),
                                );
                            },
                            child: Text(
                              "Verify",
                              style: AppTextStyles.font16BlackBold
                                  .copyWith(color: AppColors.kPrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Expanded(
              child: BlocConsumer<AppCubit, AppState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetAllUserDataLoading) {
                    return const LoadingWidget();
                  }
                  var cubit = AppCubit.get(context);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return buildUserCard(context, cubit, index);
                      },
                      itemCount: cubit.allUsers.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildUserCard(BuildContext context, AppCubit cubit, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChatDetailsScreen(
                    reciever: cubit.allUsers[index],
                  )),
        );
      },
      child: Card(
        color: SettingsCubit.get(context).isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  cubit.allUsers[index].imageUrl,
                ),
                radius: 40,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.allUsers[index].username,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      cubit.allUsers[index].email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
